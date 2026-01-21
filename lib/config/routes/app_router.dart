import 'package:go_router/go_router.dart';
import 'package:quant_ai/features/auth/presentation/pages/login_page.dart';
import 'package:quant_ai/features/auth/presentation/pages/sign_up_page.dart';
import 'package:quant_ai/features/home/presentation/pages/home_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      GoRoute(path: '/home', builder: (context, state) => const HomePage()),
      // Add more routes here
    ],
  );
}
