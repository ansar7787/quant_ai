import 'package:go_router/go_router.dart';
import 'package:quant_ai/features/auth/presentation/pages/login_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginPage()),
      // Add more routes here
    ],
  );
}
