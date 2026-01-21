import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/config/routes/app_router.dart';
import 'package:quant_ai/config/theme/app_theme.dart';
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
