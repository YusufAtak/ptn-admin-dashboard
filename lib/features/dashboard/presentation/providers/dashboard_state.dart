import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/dashboard_snapshot.dart';

part 'dashboard_state.freezed.dart';

@freezed
sealed class DashboardState with _$DashboardState {
  const factory DashboardState.initial() = DashboardInitial;
  const factory DashboardState.loading() = DashboardLoading;
  const factory DashboardState.data({
    required DashboardSnapshot snapshot,
    @Default(<String>{}) Set<String> updatingUserIds,
    String? actionMessageKey,
  }) = DashboardData;
  const factory DashboardState.failure({required String messageKey}) =
      DashboardFailure;
}
