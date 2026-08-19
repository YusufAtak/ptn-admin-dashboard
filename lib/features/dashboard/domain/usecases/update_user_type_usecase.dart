import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../repositories/dashboard_repository.dart';

class UpdateUserTypeUseCase {
  final DashboardRepository _repository;

  const UpdateUserTypeUseCase(this._repository);

  Future<Either<Failure, void>> call(String userId, String newUserTypeId) =>
      _repository.updateUserType(userId, newUserTypeId);
}
