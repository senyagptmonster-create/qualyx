import 'package:flutter/material.dart';

class QualyxPalette {
  static const Color background = Color(0xFF0A0C14);
  static const Color surface = Color(0xFF131726);
  static const Color card = Color(0xFF1B2036);
  static const Color border = Color(0xFF262D4A);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFC4B5FD);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color textMain = Color(0xFFF8FAFC);
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color errorRed = Color(0xFFEF4444);
  static const Color successGreen = Color(0xFF10B981);
}

class QualyxTypography {
  static const TextStyle heading = TextStyle(
    fontFamily: 'AppFont',
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: QualyxPalette.textMain,
    letterSpacing: -0.5,
  );

  static const TextStyle subhead = TextStyle(
    fontFamily: 'AppFont',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: QualyxPalette.textMain,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'AppFont',
    fontSize: 14,
    color: QualyxPalette.textMuted,
    height: 1.4,
  );

  static const TextStyle cellText = TextStyle(
    fontFamily: 'AppFont',
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: QualyxPalette.textMain,
  );
}
