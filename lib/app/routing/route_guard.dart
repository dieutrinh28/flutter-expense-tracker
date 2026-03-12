import 'package:go_router/go_router.dart';

import '../../modules/auth/presentation/bloc/auth_bloc.dart';

class RouteGuard {
  static const _publicRoutes = [
    '/login',
    '/register',
    '/reset-password',
  ];

  static String? onRedirect({
    required AuthState authState,
    required GoRouterState routerState,
  }) {
    final location = routerState.matchedLocation;
    final isPublicRoute = _publicRoutes.contains(location);

    return switch (authState) {
      AuthAuthenticated() => isPublicRoute ? '/home' : null,
      AuthUnauthenticated() || AuthError() => isPublicRoute ? null : '/login',
      _ => null,
    };
  }
}
