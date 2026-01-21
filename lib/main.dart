import 'package:quant_ai/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const QuantAiApp());
}

class QuantAiApp extends StatelessWidget {
  const QuantAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 📏 ScreenUtil for responsiveness
    return ScreenUtilInit(
      designSize: const Size(393, 852), // iPhone 14 Pro Dimensions
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'QuantAI',
          debugShowCheckedModeBanner: false,

          // 🎨 Theme Configuration
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,

          // 🚦 Routing
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
