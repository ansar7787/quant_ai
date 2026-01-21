import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:quant_ai/core/utils/go_router_refresh_stream.dart';
import 'package:quant_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:quant_ai/features/auth/presentation/pages/login_page.dart';
import 'package:quant_ai/features/auth/presentation/pages/sign_up_page.dart';
import 'package:quant_ai/features/home/presentation/pages/home_page.dart';

@lazySingleton
class AppRouter {
  final AuthBloc _authBloc;

  AppRouter(this._authBloc);

  late final GoRouter router = GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(_authBloc.stream),
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
    ],
    redirect: (context, state) {
      final authState = _authBloc.state;
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoginRoute = state.uri.path == '/';
      final isSignUpRoute = state.uri.path == '/signup';

      if (!isAuthenticated && !isLoginRoute && !isSignUpRoute) {
        return '/';
      }

      if (isAuthenticated && (isLoginRoute || isSignUpRoute)) {
        return '/home';
      }

      return null;
    },
  );
}
