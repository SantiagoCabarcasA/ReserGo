import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const primary = Color(0xFF6C3CE1);
  static const gradientEnd = Color(0xFF4DA5FF);
  static const background = Color(0xFFFAFAFD);
  static const border = Color(0xFFEAEAFA);
  static const textDark = Color(0xFF1A1A24);
  static const label = Color(0xFF636375);
  static const hint = Color(0xFF9797A4);
  static const icon = Color(0xFFAEAEBB);
  static const lavender = Color(0xFFF2EEFC);
  static const selectedFill = Color(0xFFEEEAFA);
  static const success = Color(0xFF10B981);
  static const successLight = Color(0xFFEBF9F4);
  static const danger = Color(0xFFEF4444);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );
    return base.copyWith(
      textTheme: GoogleFonts.outfitTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),
    );
  }
}