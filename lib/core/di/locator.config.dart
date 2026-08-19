// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:ptn_admin_dashboard/core/di/app_module.dart' as _i196;
import 'package:ptn_admin_dashboard/core/di/firebase_module.dart' as _i170;
import 'package:ptn_admin_dashboard/features/auth/data/repositories/auth_repository_impl.dart'
    as _i99;
import 'package:ptn_admin_dashboard/features/auth/domain/repositories/auth_repository.dart'
    as _i73;
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/check_admin_status_usecase.dart'
    as _i279;
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/login_admin_usecase.dart'
    as _i609;
import 'package:ptn_admin_dashboard/features/auth/domain/usecases/logout_usecase.dart'
    as _i366;
import 'package:ptn_admin_dashboard/features/dashboard/data/repositories/dashboard_repository_impl.dart'
    as _i944;
import 'package:ptn_admin_dashboard/features/dashboard/domain/repositories/dashboard_repository.dart'
    as _i725;
import 'package:ptn_admin_dashboard/features/dashboard/domain/usecases/update_user_type_usecase.dart'
    as _i284;
import 'package:ptn_admin_dashboard/features/dashboard/domain/usecases/watch_dashboard_usecase.dart'
    as _i848;
import 'package:ptn_admin_dashboard/services/firebase/firebase_auth_service.dart'
    as _i722;
import 'package:ptn_admin_dashboard/services/firebase/firebase_auth_service_impl.dart'
    as _i24;
import 'package:ptn_admin_dashboard/services/firebase/firestore_service.dart'
    as _i222;
import 'package:ptn_admin_dashboard/services/firebase/firestore_service_impl.dart'
    as _i841;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final firebaseModule = _$FirebaseModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => appModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => firebaseModule.firebaseFirestore,
    );
    gh.lazySingleton<_i722.FirebaseAuthService>(
      () => _i24.FirebaseAuthServiceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i222.FirestoreService>(
      () => _i841.FirestoreServiceImpl(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i73.AuthRepository>(
      () => _i99.AuthRepositoryImpl(
        gh<_i722.FirebaseAuthService>(),
        gh<_i222.FirestoreService>(),
      ),
    );
    gh.lazySingleton<_i725.DashboardRepository>(
      () => _i944.DashboardRepositoryImpl(gh<_i222.FirestoreService>()),
    );
    gh.lazySingleton<_i279.CheckAdminStatusUseCase>(
      () => appModule.checkAdminStatusUseCase(gh<_i73.AuthRepository>()),
    );
    gh.lazySingleton<_i609.LoginAdminUseCase>(
      () => appModule.loginAdminUseCase(gh<_i73.AuthRepository>()),
    );
    gh.lazySingleton<_i366.LogoutUseCase>(
      () => appModule.logoutUseCase(gh<_i73.AuthRepository>()),
    );
    gh.lazySingleton<_i848.WatchDashboardUseCase>(
      () => appModule.watchDashboardUseCase(gh<_i725.DashboardRepository>()),
    );
    gh.lazySingleton<_i284.UpdateUserTypeUseCase>(
      () => appModule.updateUserTypeUseCase(gh<_i725.DashboardRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i196.AppModule {}

class _$FirebaseModule extends _i170.FirebaseModule {}
