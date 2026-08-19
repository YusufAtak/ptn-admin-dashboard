enum AppRoute { login, dashboard }

extension AppRoutePath on AppRoute {
  String get path => switch (this) {
    AppRoute.login => '/login',
    AppRoute.dashboard => '/dashboard',
  };
}
