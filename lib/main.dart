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
              ? ThemeData.dark().copyWith(
                  primaryColor: const Color(0xFF00FF00),
                  scaffoldBackgroundColor: Colors.black,
                  appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                  ),
                   colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
                    primary: const Color(0xFF00FF00),
                    secondary: Colors.white,
                  ),
                )
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
