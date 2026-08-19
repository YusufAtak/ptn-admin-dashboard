import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../../../constants/firestore_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../services/firebase/firebase_auth_service.dart';
import '../../../../services/firebase/firestore_service.dart';
import '../../domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthService _authService;
  final FirestoreService _firestoreService;

  AuthRepositoryImpl(this._authService, this._firestoreService);

  @override
  Future<Either<Failure, void>> checkAdminStatus() async {
    final userId = _authService.currentUserId;
    if (userId == null) {
      return left(const Failure.auth(messageKey: 'auth.not_logged_in'));
    }
    return _verifyAdmin(userId);
  }

  @override
  Future<Either<Failure, void>> loginAdmin(
    String email,
    String password,
  ) async {
    try {
      final userId = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final result = await _verifyAdmin(userId);
      if (result.isLeft()) {
        await _authService.signOut();
      }
      return result;
    } on AuthServiceException catch (error) {
      return left(_mapAuthFailure(error));
    } catch (_) {
      return left(const Failure.auth(messageKey: 'auth.unknown_error'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _authService.signOut();
      return right(null);
    } on AuthServiceException catch (error) {
      return left(_mapAuthFailure(error));
    } catch (_) {
      return left(const Failure.auth(messageKey: 'auth.unknown_error'));
    }
  }

  Future<Either<Failure, void>> _verifyAdmin(String userId) async {
    try {
      final document = await _firestoreService.getDocument(
        PATH_USERS,
        userId,
      );
      if (document == null) {
        return left(const Failure.notFound(messageKey: 'auth.user_not_found'));
      }
      if (document[FIELD_ROLE] != USER_ROLE_ADMIN) {
        return left(
          const Failure.unauthorized(messageKey: 'auth.not_an_admin'),
        );
      }
      return right(null);
    } on FirestoreServiceException catch (error) {
      return left(_mapFirestoreFailure(error));
    } catch (_) {
      return left(const Failure.auth(messageKey: 'auth.unknown_error'));
    }
  }

  Failure _mapAuthFailure(AuthServiceException error) {
    final messageKey = switch (error.code) {
      'invalid-credential' ||
      'wrong-password' ||
      'user-not-found' => 'auth.invalid_credentials',
      'invalid-email' => 'auth.invalid_email',
      'user-disabled' => 'auth.user_disabled',
      'too-many-requests' => 'auth.too_many_requests',
      'network-request-failed' => 'auth.network_error',
      _ => 'auth.login_failed',
    };
    return Failure.auth(messageKey: messageKey, code: error.code);
  }

  Failure _mapFirestoreFailure(FirestoreServiceException error) =>
      switch (error.code) {
        'permission-denied' => const Failure.unauthorized(
          messageKey: 'dashboard.permission_denied',
        ),
        _ => Failure.server(messageKey: 'auth.login_failed', code: error.code),
      };
}
