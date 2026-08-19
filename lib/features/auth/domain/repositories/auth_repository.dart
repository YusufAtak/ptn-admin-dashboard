import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, void>> checkAdminStatus();

  Future<Either<Failure, void>> loginAdmin(String email, String password);

  Future<Either<Failure, void>> logout();
}
