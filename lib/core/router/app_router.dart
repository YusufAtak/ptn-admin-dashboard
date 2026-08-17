import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/pages/dashboard_page.dart';
import '../../presentation/pages/login_page.dart';
import '../../presentation/providers/auth_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuth = authState.status == AuthStatus.authenticated;
      final isLoginRoute = state.uri.path == '/login';

      // Still checking status, don't redirect yet
      if (authState.status == AuthStatus.authenticating || 
          authState.status == AuthStatus.initial) {
        return null;
      }

      if (!isAuth && !isLoginRoute) {
        return '/login';
      }

      if (isAuth && isLoginRoute) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
    ],
  );
});
