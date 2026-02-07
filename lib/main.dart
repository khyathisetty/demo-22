import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'utils/app_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppState.instance.getString('app_title'),
          theme: AppState.instance.isHighContrast
              ? AppTheme.lightThemeHighContrast
              : AppTheme.lightTheme,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: AppState.instance.isLargeText ? 1.5 : 1.0,
              ),
              child: child!,
            );
          },
          home: const LoginScreen(),
        );
      },
    );
  }
}
