import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class CheckAdminStatusUseCase {
  final AuthRepository _repository;

  const CheckAdminStatusUseCase(this._repository);

  Future<Either<Failure, void>> call() => _repository.checkAdminStatus();
}
