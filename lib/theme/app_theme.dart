import 'package:flutter/material.dart';

/// Indian farmer-friendly color palette: earth, wheat, farm green, terracotta.
class AppColors {
  static const Color farmGreen = Color(0xFF558B2F);
  static const Color farmGreenDark = Color(0xFF33691E);
  static const Color earthBrown = Color(0xFF6D4C41);
  static const Color earthBrownLight = Color(0xFF8D6E63);
  static const Color wheatGold = Color(0xFFFF8F00);
  static const Color wheatLight = Color(0xFFFFB74D);
  static const Color cream = Color(0xFFFFF8E1);
  static const Color creamDark = Color(0xFFFFECB3);
  static const Color terracotta = Color(0xFFBF360C);
  static const Color soil = Color(0xFF5D4037);
  static const Color skyLight = Color(0xFFE8F5E9);
}

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.farmGreen,
        scaffoldBackgroundColor: AppColors.cream,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.farmGreen,
          primary: AppColors.farmGreen,
          secondary: AppColors.earthBrownLight,
          surface: AppColors.cream,
          brightness: Brightness.light,
        ).copyWith(
          tertiary: AppColors.wheatGold,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.farmGreenDark,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shadowColor: AppColors.earthBrown.withValues(alpha: 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppColors.creamDark, width: 1),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.farmGreen,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: AppColors.creamDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.farmGreen, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          prefixIconColor: AppColors.earthBrownLight,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.soil,
          ),
          bodyMedium: TextStyle(fontSize: 16, color: AppColors.soil),
        ),
      );

  static ThemeData get lightThemeHighContrast => lightTheme.copyWith(
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF00FF00),
          surface: Colors.grey[900]!,
          onSurface: Colors.white,
        ),
      );
}
