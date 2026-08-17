import 'package:fpdart/fpdart.dart';
import '../../core/errors/failures.dart';

abstract class AuthRepository {
  /// Check if the user is currently logged in and is an admin
  Future<Either<Failure, bool>> checkAdminStatus();

  /// Logs in the admin user using email and password
  Future<Either<Failure, void>> loginAdmin(String email, String password);

  /// Logs out the current admin user
  Future<Either<Failure, void>> logout();
}
