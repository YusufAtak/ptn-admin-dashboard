import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../constants/firestore_constants.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/admin_user_summary.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final FirebaseFirestore _firestore;

  DashboardRepositoryImpl(this._firestore);

  @override
  Stream<Either<Failure, int>> watchTotalUserCount() {
    final stream = _firestore
        .collection(FirestorePaths.users)
        .snapshots()
        .map((snapshot) => snapshot.size);
    return _guardStream(stream, 'dashboard.error_fetching_users');
  }

  @override
  Stream<Either<Failure, double>> watchTotalWalletBalance() {
    final stream = _firestore
        .collection(FirestorePaths.wallets)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<double>(0, (total, document) {
            final value = document.data()[FirestoreFields.balance];
            return total + (value is num ? value.toDouble() : 0);
          }),
        );
    return _guardStream(stream, 'dashboard.error_fetching_balance');
  }

  @override
  Stream<Either<Failure, double>> watchTotalRevenue() {
    final stream = _firestore
        .collection(FirestorePaths.transactions)
        .where(FirestoreFields.type, isEqualTo: 'spend')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.fold<double>(0, (total, document) {
            final value = document.data()[FirestoreFields.amount];
            return total + (value is num ? value.toDouble() : 0);
          }),
        );
    return _guardStream(stream, 'dashboard.error_fetching_revenue');
  }

  @override
  Stream<Either<Failure, DashboardWeeklyMetrics>> watchWeeklyMetrics(
    DateTime referenceDate,
  ) {
    final today = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
    );
    final firstDay = today.subtract(const Duration(days: 6));

    final stream = _firestore
        .collection(FirestorePaths.transactions)
        .where(
          FirestoreFields.timestamp,
          isGreaterThanOrEqualTo: firstDay.millisecondsSinceEpoch,
        )
        .where(FirestoreFields.type, whereIn: ['spend', 'ticket_use'])
        .snapshots()
        .map((snapshot) => _weeklyMetrics(snapshot, firstDay));

    return _guardStream(stream, 'dashboard.error_fetching_rides');
  }

  @override
  Stream<Either<Failure, List<AdminUserSummary>>> watchUserList() {
    final controller =
        StreamController<Either<Failure, List<AdminUserSummary>>>();
    QuerySnapshot<Map<String, dynamic>>? usersSnapshot;
    QuerySnapshot<Map<String, dynamic>>? walletsSnapshot;

    void emitUsers() {
      final users = usersSnapshot;
      final wallets = walletsSnapshot;
      if (users == null || wallets == null || controller.isClosed) {
        return;
      }

      final balances = <String, double>{
        for (final document in wallets.docs)
          document.id: switch (document.data()[FirestoreFields.balance]) {
            final num value => value.toDouble(),
            _ => 0,
          },
      };

      final summaries = users.docs
          .map((document) {
            final data = document.data();
            final firstName = _stringValue(data[FirestoreFields.firstName]);
            final lastName = _stringValue(data[FirestoreFields.lastName]);
            final displayName = _stringValue(data[FirestoreFields.displayName]);

            return AdminUserSummary(
              id: document.id,
              email: _stringValue(data[FirestoreFields.email]),
              displayName: displayName.isNotEmpty
                  ? displayName
                  : '$firstName $lastName'.trim(),
              role: _stringValue(
                data[FirestoreFields.role],
                fallback: 'passenger',
              ),
              userType: _normalizeUserType(data[FirestoreFields.userType]),
              balance: balances[document.id] ?? 0,
            );
          })
          .toList(growable: false);

      controller.add(right(summaries));
    }

    void emitError(Object error) {
      if (!controller.isClosed) {
        controller.add(
          left(_mapStreamError(error, 'dashboard.error_fetching_user_list')),
        );
      }
    }

    final usersSubscription = _firestore
        .collection(FirestorePaths.users)
        .orderBy(FirestoreFields.createdAt, descending: true)
        .limit(100)
        .snapshots()
        .listen((snapshot) {
          usersSnapshot = snapshot;
          emitUsers();
        }, onError: emitError);

    final walletsSubscription = _firestore
        .collection(FirestorePaths.wallets)
        .snapshots()
        .listen((snapshot) {
          walletsSnapshot = snapshot;
          emitUsers();
        }, onError: emitError);

    controller.onCancel = () async {
      await usersSubscription.cancel();
      await walletsSubscription.cancel();
    };

    return controller.stream;
  }

  @override
  Stream<Either<Failure, Map<String, String>>> watchAvailableUserTypes() {
    final stream = _firestore
        .collection(FirestorePaths.userTypes)
        .snapshots()
        .map((snapshot) {
          final types = <String, String>{};
          for (final document in snapshot.docs) {
            if (!UserTypeIds.fallbackLabels.containsKey(document.id)) {
              continue;
            }
            types[document.id] = _userTypeLabel(
              document.data()[FirestoreFields.name],
              fallback: UserTypeIds.fallbackLabels[document.id]!,
            );
          }
          return types.isEmpty ? UserTypeIds.fallbackLabels : types;
        });

    return _guardStream(stream, 'dashboard.error_fetching_user_types');
  }

  @override
  Future<Either<Failure, void>> updateUserType(
    String userId,
    String newUserType,
  ) async {
    try {
      if (!UserTypeIds.fallbackLabels.containsKey(newUserType)) {
        return left(
          const Failure.server(messageKey: 'dashboard.invalid_user_type'),
        );
      }

      await _firestore.collection(FirestorePaths.users).doc(userId).update({
        FirestoreFields.userType: newUserType,
        FirestoreFields.updatedAt: FieldValue.serverTimestamp(),
      });
      return right(null);
    } on FirebaseException catch (error) {
      return left(_mapFirebaseFailure(error, 'dashboard.error_updating_user'));
    } catch (_) {
      return left(
        const Failure.server(messageKey: 'dashboard.error_updating_user'),
      );
    }
  }

  DashboardWeeklyMetrics _weeklyMetrics(
    QuerySnapshot<Map<String, dynamic>> snapshot,
    DateTime firstDay,
  ) {
    final days = List.generate(
      7,
      (index) =>
          DashboardDailyMetric(date: firstDay.add(Duration(days: index))),
    );

    for (final document in snapshot.docs) {
      final data = document.data();
      final rawTimestamp = data[FirestoreFields.timestamp];
      if (rawTimestamp is! num) {
        continue;
      }

      final timestamp = DateTime.fromMillisecondsSinceEpoch(
        rawTimestamp.toInt(),
      );
      final transactionDay = DateTime(
        timestamp.year,
        timestamp.month,
        timestamp.day,
      );
      final dayIndex = transactionDay.difference(firstDay).inDays;
      if (dayIndex < 0 || dayIndex >= days.length) {
        continue;
      }

      final current = days[dayIndex];
      final type = data[FirestoreFields.type];
      final amount = data[FirestoreFields.amount];
      days[dayIndex] = current.copyWith(
        rideCount: current.rideCount + 1,
        revenue:
            current.revenue +
            (type == 'spend' && amount is num ? amount.toDouble() : 0),
      );
    }

    return DashboardWeeklyMetrics(
      todayRideCount: days.last.rideCount,
      days: days,
    );
  }

  Stream<Either<Failure, T>> _guardStream<T>(
    Stream<T> source,
    String messageKey,
  ) async* {
    try {
      await for (final value in source) {
        yield right(value);
      }
    } catch (error) {
      yield left(_mapStreamError(error, messageKey));
    }
  }

  Failure _mapStreamError(Object error, String messageKey) {
    return error is FirebaseException
        ? _mapFirebaseFailure(error, messageKey)
        : Failure.server(messageKey: messageKey);
  }

  Failure _mapFirebaseFailure(
    FirebaseException error,
    String fallbackMessageKey,
  ) {
    final requiresIndex =
        error.code == 'failed-precondition' ||
        (error.message?.contains('requires an index') ?? false);
    if (requiresIndex) {
      return Failure.server(
        messageKey: 'dashboard.missing_index',
        code: error.code,
      );
    }

    return switch (error.code) {
      'permission-denied' => Failure.unauthorized(
        messageKey: 'dashboard.permission_denied',
      ),
      _ => Failure.server(messageKey: fallbackMessageKey, code: error.code),
    };
  }

  String _normalizeUserType(Object? value) {
    if (value is String && UserTypeIds.fallbackLabels.containsKey(value)) {
      return value;
    }
    return switch (value) {
      'student' => UserTypeIds.student,
      'elderly' => UserTypeIds.elderly,
      _ => UserTypeIds.full,
    };
  }

  String _userTypeLabel(Object? value, {required String fallback}) {
    if (value is String && value.trim().isNotEmpty) {
      return value;
    }
    if (value is Map) {
      final turkish = value['tr'];
      if (turkish is String && turkish.trim().isNotEmpty) {
        return turkish;
      }
      final english = value['en'];
      if (english is String && english.trim().isNotEmpty) {
        return english;
      }
    }
    return fallback;
  }

  String _stringValue(Object? value, {String fallback = ''}) {
    return value is String ? value : fallback;
  }
}
