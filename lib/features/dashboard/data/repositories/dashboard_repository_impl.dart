import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../constants/dashboard_constants.dart';
import '../../../../constants/firestore_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../services/firebase/firestore_query.dart';
import '../../../../services/firebase/firestore_service.dart';
import '../../domain/entities/dashboard_metrics.dart';
import '../../domain/entities/dashboard_snapshot.dart';
import '../../domain/entities/user_type_option.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../models/admin_user_model.dart';
import '../models/transaction_model.dart';
import '../models/user_type_model.dart';
import '../models/wallet_model.dart';

@LazySingleton(as: DashboardRepository)
class DashboardRepositoryImpl implements DashboardRepository {
  final FirestoreService _firestoreService;

  DashboardRepositoryImpl(this._firestoreService);

  @override
  Stream<Either<Failure, DashboardSnapshot>> watchDashboard(
    DateTime referenceDate,
  ) {
    final controller = StreamController<Either<Failure, DashboardSnapshot>>();
    List<Map<String, dynamic>>? userDocuments;
    List<Map<String, dynamic>>? walletDocuments;
    List<Map<String, dynamic>>? transactionDocuments;
    List<Map<String, dynamic>>? userTypeDocuments;

    final today = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
    );
    final firstDay = today.subtract(
      const Duration(days: DASHBOARD_PREVIOUS_DAY_COUNT),
    );

    void emitSnapshot() {
      final users = userDocuments;
      final wallets = walletDocuments;
      final transactions = transactionDocuments;
      final userTypes = userTypeDocuments;
      if (users == null ||
          wallets == null ||
          transactions == null ||
          userTypes == null ||
          controller.isClosed) {
        return;
      }
      try {
        controller.add(
          right(
            _createSnapshot(
              users: users,
              wallets: wallets,
              transactions: transactions,
              userTypes: userTypes,
              firstDay: firstDay,
            ),
          ),
        );
      } catch (_) {
        controller.add(
          left(
            const Failure.server(messageKey: 'dashboard.error_parsing_data'),
          ),
        );
      }
    }

    void emitError(Object error) {
      if (!controller.isClosed) {
        controller.add(left(_mapServiceFailure(error)));
      }
    }

    final usersSubscription = _firestoreService
        .watchCollection(
          PATH_USERS,
          options: const FirestoreQueryOptions(
            filters: [
              FirestoreFilter(
                field: FIELD_ROLE,
                operator: FirestoreFilterOperator.equalTo,
                value: USER_ROLE_PASSENGER,
              ),
            ],
          ),
        )
        .listen((value) {
          userDocuments = value;
          emitSnapshot();
        }, onError: emitError);

    final walletsSubscription = _firestoreService
        .watchCollection(PATH_WALLETS)
        .listen((value) {
          walletDocuments = value;
          emitSnapshot();
        }, onError: emitError);

    final transactionsSubscription = _firestoreService
        .watchCollection(
          PATH_TRANSACTIONS,
          options: const FirestoreQueryOptions(
            filters: [
              FirestoreFilter(
                field: FIELD_TYPE,
                operator: FirestoreFilterOperator.whereIn,
                value: RIDE_TRANSACTION_TYPES,
              ),
            ],
          ),
        )
        .listen((value) {
          transactionDocuments = value;
          emitSnapshot();
        }, onError: emitError);

    final userTypesSubscription = _firestoreService
        .watchCollection(PATH_USER_TYPES)
        .listen((value) {
          userTypeDocuments = value;
          emitSnapshot();
        }, onError: emitError);

    controller.onCancel = () {
      usersSubscription.cancel();
      walletsSubscription.cancel();
      transactionsSubscription.cancel();
      userTypesSubscription.cancel();
    };
    return controller.stream;
  }

  @override
  Future<Either<Failure, void>> updateUserType(
    String userId,
    String newUserTypeId,
  ) async {
    if (!UserTypeModel.fallbackOptions.any(
      (option) => option.id == newUserTypeId,
    )) {
      return left(
        const Failure.server(messageKey: 'dashboard.invalid_user_type'),
      );
    }
    try {
      await _firestoreService.updateDocument(PATH_USERS, userId, {
        FIELD_USER_TYPE: newUserTypeId,
      }, stampUpdatedAt: true);
      return right(null);
    } on FirestoreServiceException catch (error) {
      return left(_mapServiceFailure(error));
    } catch (_) {
      return left(
        const Failure.server(messageKey: 'dashboard.error_updating_user'),
      );
    }
  }

  DashboardSnapshot _createSnapshot({
    required List<Map<String, dynamic>> users,
    required List<Map<String, dynamic>> wallets,
    required List<Map<String, dynamic>> transactions,
    required List<Map<String, dynamic>> userTypes,
    required DateTime firstDay,
  }) {
    final walletModels = wallets.map(WalletModel.fromJson).toList();
    final balances = {
      for (final wallet in walletModels) wallet.id: wallet.balance,
    };
    final userModels = users
        .map(AdminUserModel.fromJson)
        .where((user) => user.role == USER_ROLE_PASSENGER)
        .toList(growable: false)
      ..sort(
        (first, second) => second.createdAt.compareTo(first.createdAt),
      );
    final userSummaries = userModels
        .take(DASHBOARD_RECENT_USER_LIMIT)
        .map((user) => user.toDomain(balance: balances[user.id] ?? 0))
        .toList(growable: false);
    final transactionModels = transactions
        .map(TransactionModel.fromJson)
        .toList(growable: false);
    final typeOptions = userTypes
        .map(UserTypeModel.fromJson)
        .map((model) => model.toDomain())
        .whereType<UserTypeOption>()
        .toList(growable: false);

    return DashboardSnapshot(
      totalUserCount: userModels.length,
      totalWalletBalance: walletModels.fold(
        0,
        (total, wallet) => total + wallet.balance,
      ),
      totalRevenue: transactionModels.fold(
        0,
        (total, transaction) =>
            total +
            (transaction.type == TRANSACTION_TYPE_SPEND
                ? transaction.amount
                : 0),
      ),
      weeklyMetrics: _weeklyMetrics(transactionModels, firstDay),
      users: userSummaries,
      userTypes: typeOptions.isEmpty
          ? UserTypeModel.fallbackOptions
          : typeOptions,
    );
  }

  DashboardWeeklyMetrics _weeklyMetrics(
    List<TransactionModel> transactions,
    DateTime firstDay,
  ) {
    final days = List.generate(
      DASHBOARD_VISIBLE_DAY_COUNT,
      (index) =>
          DashboardDailyMetric(date: firstDay.add(Duration(days: index))),
    );
    for (final transaction in transactions) {
      final timestamp = DateTime.fromMillisecondsSinceEpoch(
        transaction.timestamp,
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
      days[dayIndex] = current.copyWith(
        rideCount: current.rideCount + 1,
        revenue:
            current.revenue +
            (transaction.type == TRANSACTION_TYPE_SPEND
                ? transaction.amount
                : 0),
      );
    }
    return DashboardWeeklyMetrics(
      todayRideCount: days.last.rideCount,
      days: days,
    );
  }

  Failure _mapServiceFailure(Object error) {
    if (error is! FirestoreServiceException) {
      return const Failure.server(messageKey: 'dashboard.unknown_error');
    }
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
      'permission-denied' => const Failure.unauthorized(
        messageKey: 'dashboard.permission_denied',
      ),
      _ => Failure.server(
        messageKey: 'dashboard.unknown_error',
        code: error.code,
      ),
    };
  }
}
