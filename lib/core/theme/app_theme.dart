import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Primary brand colors
  static const Color primary = Color(0xFF0070F0);
  static const Color primaryContainer = Color(0xFFEBF4FF);

  // Neutral & Text colors
  static const Color textDark = Color(0xFF202325);
  static const Color textPrimary = Color(0xFF303437);
  static const Color textSecondary = Color(0xFF404446);
  static const Color textMuted = Color(0xFF72777A);
  static const Color textSubtle = Color(0xFF979C9E);

  // Background & Surfaces
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceAlt = Color(0xFFF7F9FA);
  static const Color border = Color(0xFFF2F4F5);

  // Accents & Gamification
  static const Color fitnessPurple = Color(0xFF5555CB);
  static const Color fitnessBg = Color(0xFFF0F0FF);
  static const Color warmupOrange = Color(0xFFA05E03);
  static const Color warmupBg = Color(0xFFFFF9F0);

  static const Color caloriesCoral = Color(0xFFFF929A);
  static const Color stepsGold = Color(0xFFFFCE7B);
  static const Color sleepBlue = Color(0xFF8ED8F8);
  static const Color activityGreen = Color(0xFF4CD471);
  static const Color notificationRed = Color(0xFFFF6161);

  static const Color navDark = Color(0xFF303437);
  static const Color navActiveText = Color(0xFFF2F4F5);
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.dmSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        primaryContainer: AppColors.primaryContainer,
        secondary: AppColors.fitnessPurple,
        tertiary: AppColors.stepsGold,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        error: AppColors.notificationRed,
      ),
      textTheme: baseTextTheme.copyWith(
        displayLarge: GoogleFonts.dmSans(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          height: 1.25,
        ),
        headlineLarge: GoogleFonts.dmSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          height: 1.33,
        ),
        headlineMedium: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          height: 1.3,
        ),
        titleLarge: GoogleFonts.dmSans(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: AppColors.textSecondary,
          height: 1.33,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
          height: 1.25,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
          height: 1.4,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textMuted,
          height: 1.4,
        ),
        labelSmall: GoogleFonts.dmSans(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.4,
        ),
      ),
      cardTheme: CardTheme(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadowColor: Colors.black.withOpacity(0.05),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.textDark,
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
    );
  }
}
