import 'package:flutter/material.dart';

class AppColors {
  // Primary - deep navy blue
  static const Color primary = Color(0xFF12345A);
  // Secondary - teal green
  static const Color secondary = Color(0xFF159A91);
  // Backgrounds
  static const Color backgroundLight = Color(0xFFF7F9FC);
  static const Color backgroundWhite = Colors.white;
  // Text
  static const Color textDark = Color(0xFF1F2937);
  // Accent - muted gold
  static const Color accent = Color(0xFFD9A441);
  // Status colors (example)
  static const Color pending = Colors.orange;
  static const Color accepted = Colors.green;
  static const Color completed = Colors.blueGrey;
  static const Color cancelled = Colors.redAccent;
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  fontFamily: 'Inter',
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.textDark, fontSize: 16),
    bodyMedium: TextStyle(color: AppColors.textDark, fontSize: 14),
    bodySmall: TextStyle(color: AppColors.textDark, fontSize: 12),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: AppColors.primary,
    unselectedItemColor: AppColors.textDark,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.secondary),
    ),
  ),
);
