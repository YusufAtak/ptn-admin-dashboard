import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../core/errors/exceptions.dart';
import 'firebase_auth_service.dart';

@LazySingleton(as: FirebaseAuthService)
class FirebaseAuthServiceImpl implements FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthServiceImpl(this._firebaseAuth);

  @override
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  @override
  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userId = credential.user?.uid;
      if (userId == null) {
        throw const AuthServiceException('unknown');
      }
      return userId;
    } on FirebaseAuthException catch (error) {
      throw AuthServiceException(error.code, message: error.message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (error) {
      throw AuthServiceException(error.code, message: error.message);
    }
  }
}
