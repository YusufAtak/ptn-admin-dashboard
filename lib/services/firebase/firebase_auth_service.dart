abstract interface class FirebaseAuthService {
  String? get currentUserId;

  Future<String> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();
}
