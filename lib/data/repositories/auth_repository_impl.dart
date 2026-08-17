import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepositoryImpl(this._auth, this._firestore);

  @override
  Future<Either<Failure, bool>> checkAdminStatus() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return left(const Failure.auth(messageKey: 'auth.not_logged_in'));
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        return left(const Failure.notFound(messageKey: 'auth.user_not_found'));
      }

      final role = doc.data()?['role'] as String?;
      if (role == 'admin') {
        return right(true);
      } else {
        return left(
          const Failure.unauthorized(messageKey: 'auth.not_an_admin'),
        );
      }
    } on FirebaseAuthException catch (e) {
      return left(_mapAuthException(e));
    } catch (e) {
      return left(const Failure.unknown());
    }
  }

  @override
  Future<Either<Failure, void>> loginAdmin(
    String email,
    String password,
  ) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        return left(const Failure.auth(messageKey: 'auth.unknown_error'));
      }

      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (!doc.exists) {
        await _auth.signOut();
        return left(const Failure.notFound(messageKey: 'auth.user_not_found'));
      }

      final role = doc.data()?['role'] as String?;
      if (role != 'admin') {
        await _auth.signOut();
        return left(
          const Failure.unauthorized(messageKey: 'auth.not_an_admin'),
        );
      }

      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(_mapAuthException(e));
    } catch (e) {
      return left(const Failure.unknown());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _auth.signOut();
      return right(null);
    } catch (e) {
      return left(const Failure.unknown());
    }
  }

  Failure _mapAuthException(FirebaseAuthException error) {
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
}
