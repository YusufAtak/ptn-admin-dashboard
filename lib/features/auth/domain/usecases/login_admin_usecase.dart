import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class LoginAdminUseCase {
  final AuthRepository _repository;

  const LoginAdminUseCase(this._repository);

  Future<Either<Failure, void>> call(String email, String password) =>
      _repository.loginAdmin(email, password);
}
