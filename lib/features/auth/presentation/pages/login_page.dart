import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:quant_ai/di/injection.dart';
import 'package:quant_ai/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: theme.colorScheme.error,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            } else if (state is AuthAuthenticated) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Welcome back to QuantAI'),
                  backgroundColor: theme.primaryColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
              context.go('/home');
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                // Background Elements
                Positioned(
                  top: -100,
                  right: -100,
                  child:
                      Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme.primaryColor.withOpacity(0.1),
                              blurRadius: 100,
                            ),
                          )
                          .animate()
                          .scale(duration: 2.seconds, curve: Curves.easeInOut)
                          .then()
                          .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(0.8, 0.8),
                            duration: 2.seconds,
                          ),
                ),

                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Logo / Icon
                            Icon(
                                  Icons
                                      .stacked_line_chart_rounded, // Fintech vibes
                                  size: 80.sp,
                                  color: theme.primaryColor,
                                )
                                .animate()
                                .fadeIn(duration: 600.ms)
                                .scale(delay: 200.ms),

                            SizedBox(height: 16.h),

                            Text(
                                  'QuantAI',
                                  textAlign: TextAlign.center,
                                  style: theme.textTheme.displaySmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.5,
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .slideY(begin: 0.2, end: 0),

                            SizedBox(height: 8.h),

                            Text(
                              'Master Your Wealth',
                              textAlign: TextAlign.center,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: Colors.grey,
                              ),
                            ).animate().fadeIn(delay: 600.ms),

                            SizedBox(height: 48.h),

                            // Inputs
                            _buildTextField(
                                  controller: _emailController,
                                  label: 'Email Address',
                                  icon: Icons.alternate_email_rounded,
                                  theme: theme,
                                )
                                .animate()
                                .fadeIn(delay: 800.ms)
                                .slideX(begin: -0.2, end: 0),

                            SizedBox(height: 16.h),

                            _buildTextField(
                                  controller: _passwordController,
                                  label: 'Password',
                                  icon: Icons.lock_outline_rounded,
                                  isPassword: true,
                                  theme: theme,
                                )
                                .animate()
                                .fadeIn(delay: 1000.ms)
                                .slideX(begin: 0.2, end: 0),

                            SizedBox(height: 32.h),

                            // Login Button
                            SizedBox(
                              height: 56.h,
                              child: FilledButton(
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context.read<AuthBloc>().add(
                                            AuthLoginRequested(
                                              email: _emailController.text,
                                              password:
                                                  _passwordController.text,
                                            ),
                                          );
                                        }
                                      },
                                style: FilledButton.styleFrom(
                                  backgroundColor: theme.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  elevation: 4,
                                  shadowColor: theme.primaryColor.withOpacity(
                                    0.4,
                                  ),
                                ),
                                child: state is AuthLoading
                                    ? const CircularProgressIndicator.adaptive(
                                        backgroundColor: Colors.white,
                                      )
                                    : Text(
                                        'Login',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ).animate().fadeIn(delay: 1200.ms).scale(),

                            SizedBox(height: 24.h),

                            // Sign Up Configuration
                            Center(
                              child: TextButton(
                                onPressed: () => context.push('/signup'),
                                child: RichText(
                                  text: TextSpan(
                                    text: "Don't have an account? ",
                                    style: TextStyle(color: Colors.grey),
                                    children: [
                                      TextSpan(
                                        text: 'Sign Up',
                                        style: TextStyle(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(delay: 1400.ms),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    required ThemeData theme,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[600]),
          prefixIcon: Icon(icon, color: theme.primaryColor.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: theme.primaryColor, width: 1.5),
          ),
          filled: true,
          fillColor: theme.cardColor,
          contentPadding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 20.w,
          ),
        ),
        validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
      ),
    );
  }
}
