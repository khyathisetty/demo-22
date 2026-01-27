import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: const Color(0xFF7FB77E), // pastel green
    scaffoldBackgroundColor: const Color(0xFFF5F7F2),
    fontFamily: 'Roboto',
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF7FB77E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2F5233),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Color(0xFF4E6E58),
      ),
    ),
  );
}
