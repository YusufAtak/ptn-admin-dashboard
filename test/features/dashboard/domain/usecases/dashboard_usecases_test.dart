import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptn_admin_dashboard/core/errors/failures.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/dashboard_metrics.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/entities/dashboard_snapshot.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/usecases/update_user_type_usecase.dart';
import 'package:ptn_admin_dashboard/features/dashboard/domain/usecases/watch_dashboard_usecase.dart';

class _MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late _MockDashboardRepository repository;
  final referenceDate = DateTime(2026, 8, 17);
  final snapshot = DashboardSnapshot(
    totalUserCount: 1,
    totalWalletBalance: 10,
    totalRevenue: 5,
    weeklyMetrics: const DashboardWeeklyMetrics(),
  );

  setUp(() {
    repository = _MockDashboardRepository();
  });

  group('WatchDashboardUseCase', () {
    test('forwards live dashboard stream', () async {
      when(() => repository.watchDashboard(referenceDate)).thenAnswer(
        (_) => Stream.value(right<Failure, DashboardSnapshot>(snapshot)),
      );
      final useCase = WatchDashboardUseCase(repository);

      final result = await useCase(referenceDate).first;

      expect(result, right<Failure, DashboardSnapshot>(snapshot));
      verify(() => repository.watchDashboard(referenceDate)).called(1);
    });

    test('forwards stream failure', () async {
      const failure = Failure.server(messageKey: 'dashboard.unknown_error');
      when(() => repository.watchDashboard(referenceDate)).thenAnswer(
        (_) => Stream.value(left<Failure, DashboardSnapshot>(failure)),
      );
      final useCase = WatchDashboardUseCase(repository);

      final result = await useCase(referenceDate).first;

      expect(result, left<Failure, DashboardSnapshot>(failure));
    });
  });

  group('UpdateUserTypeUseCase', () {
    test('forwards user and type identifiers', () async {
      when(
        () => repository.updateUserType(any(), any()),
      ).thenAnswer((_) async => right<Failure, void>(null));
      final useCase = UpdateUserTypeUseCase(repository);

      final result = await useCase('user-id', 'student-id');

      expect(result.isRight(), isTrue);
      verify(
        () => repository.updateUserType('user-id', 'student-id'),
      ).called(1);
    });

    test('forwards update failure', () async {
      const failure = Failure.server(
        messageKey: 'dashboard.error_updating_user',
      );
      when(
        () => repository.updateUserType(any(), any()),
      ).thenAnswer((_) async => left<Failure, void>(failure));
      final useCase = UpdateUserTypeUseCase(repository);

      final result = await useCase('user-id', 'student-id');

      expect(result, left<Failure, void>(failure));
    });
  });
}
