import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/dashboard_snapshot.dart';
import '../repositories/dashboard_repository.dart';

class WatchDashboardUseCase {
  final DashboardRepository _repository;

  const WatchDashboardUseCase(this._repository);

  Stream<Either<Failure, DashboardSnapshot>> call(DateTime referenceDate) =>
      _repository.watchDashboard(referenceDate);
}
