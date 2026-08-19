import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_admin_status_usecase.dart';
import '../../features/auth/domain/usecases/login_admin_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/update_user_type_usecase.dart';
import '../../features/dashboard/domain/usecases/watch_dashboard_usecase.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get sharedPreferences =>
      SharedPreferences.getInstance();

  @lazySingleton
  CheckAdminStatusUseCase checkAdminStatusUseCase(AuthRepository repository) =>
      CheckAdminStatusUseCase(repository);

  @lazySingleton
  LoginAdminUseCase loginAdminUseCase(AuthRepository repository) =>
      LoginAdminUseCase(repository);

  @lazySingleton
  LogoutUseCase logoutUseCase(AuthRepository repository) =>
      LogoutUseCase(repository);

  @lazySingleton
  WatchDashboardUseCase watchDashboardUseCase(DashboardRepository repository) =>
      WatchDashboardUseCase(repository);

  @lazySingleton
  UpdateUserTypeUseCase updateUserTypeUseCase(DashboardRepository repository) =>
      UpdateUserTypeUseCase(repository);
}
