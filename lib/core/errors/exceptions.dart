sealed class AppServiceException implements Exception {
  final String code;
  final String? message;

  const AppServiceException(this.code, {this.message});
}

final class AuthServiceException extends AppServiceException {
  const AuthServiceException(super.code, {super.message});
}

final class FirestoreServiceException extends AppServiceException {
  const FirestoreServiceException(super.code, {super.message});
}
