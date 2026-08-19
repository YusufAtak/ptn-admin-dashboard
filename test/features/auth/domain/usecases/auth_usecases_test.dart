import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ptn_admin_dashboard/core/errors/failures.dart';
import 'package:ptn_admin_dashboard/features/auth/domain/repositories/auth_repository.dart';
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/check_admin_status_usecase.dart';
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/login_admin_usecase.dart';
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/logout_usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;

  setUp(() {
    repository = _MockAuthRepository();
  });

  group('CheckAdminStatusUseCase', () {
    test('forwards successful result from repository', () async {
      when(
        repository.checkAdminStatus,
      ).thenAnswer((_) async => right<Failure, void>(null));
      final useCase = CheckAdminStatusUseCase(repository);

      final result = await useCase();

      expect(result.isRight(), isTrue);
      verify(repository.checkAdminStatus).called(1);
    });

    test('forwards failure from repository', () async {
      const failure = Failure.auth(messageKey: 'auth.not_logged_in');
      when(
        repository.checkAdminStatus,
      ).thenAnswer((_) async => left<Failure, void>(failure));
      final useCase = CheckAdminStatusUseCase(repository);

      final result = await useCase();

      expect(result, left<Failure, void>(failure));
    });
  });

  group('LoginAdminUseCase', () {
    test('forwards credentials and successful result', () async {
      when(
        () => repository.loginAdmin(any(), any()),
      ).thenAnswer((_) async => right<Failure, void>(null));
      final useCase = LoginAdminUseCase(repository);

      final result = await useCase('admin@example.com', 'password');

      expect(result.isRight(), isTrue);
      verify(
        () => repository.loginAdmin('admin@example.com', 'password'),
      ).called(1);
    });

    test('forwards login failure', () async {
      const failure = Failure.auth(messageKey: 'auth.invalid_credentials');
      when(
        () => repository.loginAdmin(any(), any()),
      ).thenAnswer((_) async => left<Failure, void>(failure));
      final useCase = LoginAdminUseCase(repository);

      final result = await useCase('admin@example.com', 'wrong-password');

      expect(result, left<Failure, void>(failure));
    });
  });

  group('LogoutUseCase', () {
    test('forwards successful result from repository', () async {
      when(
        repository.logout,
      ).thenAnswer((_) async => right<Failure, void>(null));
      final useCase = LogoutUseCase(repository);

      final result = await useCase();

      expect(result.isRight(), isTrue);
      verify(repository.logout).called(1);
    });

    test('forwards logout failure', () async {
      const failure = Failure.auth(messageKey: 'auth.network_error');
      when(
        repository.logout,
      ).thenAnswer((_) async => left<Failure, void>(failure));
      final useCase = LogoutUseCase(repository);

      final result = await useCase();

      expect(result, left<Failure, void>(failure));
    });
  });
}
