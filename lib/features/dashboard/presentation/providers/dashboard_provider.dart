import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../constants/durations.dart';
import '../../../../core/di/providers.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/dashboard_snapshot.dart';
import 'dashboard_state.dart';

class DashboardNotifier extends Notifier<DashboardState> {
  StreamSubscription<Either<Failure, DashboardSnapshot>>? _subscription;
  Timer? _midnightTimer;

  @override
  DashboardState build() {
    _connect();
    ref.onDispose(() {
      _subscription?.cancel();
      _midnightTimer?.cancel();
    });
    return const DashboardState.loading();
  }

  Future<void> refresh() async {
    _subscription?.cancel();
    _subscription = null;
    _connect();
  }

  Future<void> updateUserType(String userId, String userTypeId) async {
    final currentState = state;
    if (currentState is! DashboardData ||
        currentState.updatingUserIds.contains(userId)) {
      return;
    }

    state = currentState.copyWith(
      updatingUserIds: {...currentState.updatingUserIds, userId},
      actionMessageKey: null,
    );
    final result = await ref.read(updateUserTypeUseCaseProvider)(
      userId,
      userTypeId,
    );
    final latestState = state;
    if (latestState is! DashboardData) {
      return;
    }
    final updatingUserIds = {...latestState.updatingUserIds}..remove(userId);
    state = result.fold(
      (failure) => latestState.copyWith(
        updatingUserIds: updatingUserIds,
        actionMessageKey: failure.messageKey,
      ),
      (_) => latestState.copyWith(updatingUserIds: updatingUserIds),
    );
  }

  void clearActionMessage() {
    final currentState = state;
    if (currentState is DashboardData &&
        currentState.actionMessageKey != null) {
      state = currentState.copyWith(actionMessageKey: null);
    }
  }

  void _connect() {
    final now = DateTime.now();
    _subscription = ref
        .read(watchDashboardUseCaseProvider)(now)
        .listen(
          (result) {
            state = result.fold(
              (failure) =>
                  DashboardState.failure(messageKey: failure.messageKey),
              (snapshot) => DashboardState.data(snapshot: snapshot),
            );
          },
          onError: (_) {
            state = const DashboardState.failure(
              messageKey: 'dashboard.unknown_error',
            );
          },
        );
    _scheduleMidnightRefresh(now);
  }

  void _scheduleMidnightRefresh(DateTime now) {
    _midnightTimer?.cancel();
    final nextDay = DateTime(now.year, now.month, now.day + 1);
    _midnightTimer = Timer(
      nextDay.difference(now) + MIDNIGHT_REFRESH_DELAY,
      refresh,
    );
  }
}

final dashboardProvider = NotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);
