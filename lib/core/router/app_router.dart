import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/providers/auth_state.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import 'app_route.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppRoute.login.path,
    redirect: (context, state) {
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.uri.path == AppRoute.login.path;

      if (authState is AuthInitial || authState is AuthLoading) {
        return null;
      }

      if (!isAuthenticated && !isLoginRoute) {
        return AppRoute.login.path;
      }

      if (isAuthenticated && isLoginRoute) {
        return AppRoute.dashboard.path;
      }

      return null;
    },
    routes: [
      GoRoute(
        name: AppRoute.login.name,
        path: AppRoute.login.path,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        name: AppRoute.dashboard.name,
        path: AppRoute.dashboard.path,
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
});
