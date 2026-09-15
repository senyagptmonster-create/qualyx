import 'package:flutter/material.dart';

class QualyxTheme {
  static const background = Color(0xFF090A10);
  static const surface = Color(0xFF121420);
  static const card = Color(0xFF1E2235);
  static const violet = Color(0xFF8B5CF6);
  static const purple = Color(0xFFA78BFA);
  static const cyan = Color(0xFF06B6D4);
  static const textPrimary = Color(0xFFF5F3FF);
  static const textSecondary = Color(0xFF94A3B8);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: violet,
      cardColor: card,
      fontFamily: 'AppFont',
      colorScheme: const ColorScheme.dark(
        primary: violet,
        secondary: cyan,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
