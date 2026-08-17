import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/di/providers.dart';
import '../../core/errors/failures.dart';
import '../../domain/entities/admin_user_summary.dart';
import '../../domain/entities/dashboard_metrics.dart';

class DashboardStreamException implements Exception {
  final String messageKey;

  const DashboardStreamException(this.messageKey);
}

T _unwrap<T>(Either<Failure, T> result) {
  return result.fold(
    (failure) => throw DashboardStreamException(failure.messageKey),
    (value) => value,
  );
}

final totalUserCountProvider = StreamProvider.autoDispose<int>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.watchTotalUserCount().map(_unwrap);
});

final totalWalletBalanceProvider = StreamProvider.autoDispose<double>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.watchTotalWalletBalance().map(_unwrap);
});

final totalRevenueProvider = StreamProvider.autoDispose<double>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.watchTotalRevenue().map(_unwrap);
});

final weeklyMetricsProvider =
    StreamProvider.autoDispose<DashboardWeeklyMetrics>((ref) {
      final now = DateTime.now();
      final nextDay = DateTime(now.year, now.month, now.day + 1);
      final midnightTimer = Timer(
        nextDay.difference(now) + const Duration(seconds: 1),
        ref.invalidateSelf,
      );
      ref.onDispose(midnightTimer.cancel);

      final repository = ref.watch(dashboardRepositoryProvider);
      return repository.watchWeeklyMetrics(now).map(_unwrap);
    });

final dashboardUsersProvider =
    StreamProvider.autoDispose<List<AdminUserSummary>>((ref) {
      final repository = ref.watch(dashboardRepositoryProvider);
      return repository.watchUserList().map(_unwrap);
    });

final userTypesProvider = StreamProvider.autoDispose<Map<String, String>>((
  ref,
) {
  final repository = ref.watch(dashboardRepositoryProvider);
  return repository.watchAvailableUserTypes().map(_unwrap);
});

class UserTypeUpdateNotifier extends Notifier<Set<String>> {
  @override
  Set<String> build() => const {};

  Future<String?> updateUserType(String userId, String userTypeId) async {
    if (state.contains(userId)) {
      return null;
    }

    state = {...state, userId};
    final result = await ref
        .read(dashboardRepositoryProvider)
        .updateUserType(userId, userTypeId);
    state = {...state}..remove(userId);

    return result.fold((failure) => failure.messageKey, (_) => null);
  }
}

final userTypeUpdateProvider =
    NotifierProvider<UserTypeUpdateNotifier, Set<String>>(
      UserTypeUpdateNotifier.new,
    );

void refreshDashboard(WidgetRef ref) {
  ref.invalidate(totalUserCountProvider);
  ref.invalidate(totalWalletBalanceProvider);
  ref.invalidate(totalRevenueProvider);
  ref.invalidate(weeklyMetricsProvider);
  ref.invalidate(dashboardUsersProvider);
  ref.invalidate(userTypesProvider);
}
