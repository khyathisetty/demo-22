import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF2E7D32), // Darker green
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    fontFamily: 'Roboto',
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color(0xFF2E7D32),
      secondary: const Color(0xFF81C784),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF2E7D32),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1B5E20),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Color(0xFF333333),
      ),
    ),
    cardTheme: const CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.white,
    ),
  );
}
