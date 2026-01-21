import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quant_ai/config/env.dart';
import 'package:quant_ai/config/routes/app_router.dart';
import 'package:quant_ai/config/theme/app_theme.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseAnonKey);

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
        return BlocProvider(
          create: (_) => getIt<AuthBloc>(),
          child: MaterialApp.router(
            title: 'QuantAI',
            debugShowCheckedModeBanner: false,

            // 🎨 Theme Configuration
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,

            // 🚦 Routing
            routerConfig: getIt<AppRouter>().router,
          ),
        );
      },
    );
  }
}
