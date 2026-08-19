import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/domain/usecases/check_admin_status_usecase.dart';
import '../../features/auth/domain/usecases/login_admin_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/dashboard/domain/usecases/update_user_type_usecase.dart';
import '../../features/dashboard/domain/usecases/watch_dashboard_usecase.dart';
import 'locator.dart';

final checkAdminStatusUseCaseProvider = Provider<CheckAdminStatusUseCase>(
  (ref) => getIt<CheckAdminStatusUseCase>(),
);

final loginAdminUseCaseProvider = Provider<LoginAdminUseCase>(
  (ref) => getIt<LoginAdminUseCase>(),
);

final logoutUseCaseProvider = Provider<LogoutUseCase>(
  (ref) => getIt<LogoutUseCase>(),
);

final watchDashboardUseCaseProvider = Provider<WatchDashboardUseCase>(
  (ref) => getIt<WatchDashboardUseCase>(),
);

final updateUserTypeUseCaseProvider = Provider<UpdateUserTypeUseCase>(
  (ref) => getIt<UpdateUserTypeUseCase>(),
);
