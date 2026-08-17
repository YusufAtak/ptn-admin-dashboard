import 'package:fpdart/fpdart.dart';

import '../../core/errors/failures.dart';
import '../entities/admin_user_summary.dart';
import '../entities/dashboard_metrics.dart';

abstract interface class DashboardRepository {
  Stream<Either<Failure, int>> watchTotalUserCount();

  Stream<Either<Failure, double>> watchTotalWalletBalance();

  Stream<Either<Failure, double>> watchTotalRevenue();

  Stream<Either<Failure, DashboardWeeklyMetrics>> watchWeeklyMetrics(
    DateTime referenceDate,
  );

  Stream<Either<Failure, List<AdminUserSummary>>> watchUserList();

  Stream<Either<Failure, Map<String, String>>> watchAvailableUserTypes();

  Future<Either<Failure, void>> updateUserType(
    String userId,
    String newUserType,
  );
}
