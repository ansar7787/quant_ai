import 'package:go_router/go_router.dart';
import 'package:quant_ai/main.dart'; // Will point to pages later

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Placeholder(), // TODO: Replace with LoginPage
      ),
      // Add more routes here
    ],
  );
}
