import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/dashboard_snapshot.dart';

abstract interface class DashboardRepository {
  Stream<Either<Failure, DashboardSnapshot>> watchDashboard(
    DateTime referenceDate,
  );

  Future<Either<Failure, void>> updateUserType(
    String userId,
    String newUserTypeId,
  );
}
