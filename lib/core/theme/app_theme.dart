import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Defines Light and Dark Material 3 themes for LocalLink.
abstract final class AppTheme {
  /// Base text theme with increased line-height to guarantee that
  /// Devanagari conjuncts and vowels (Hindi & Marathi matras) do not clip.
  static TextTheme _buildTextTheme({
    required Color textPrimary,
    required Color textSecondary,
  }) {
    final base = GoogleFonts.interTextTheme();
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.bold,
        height: 1.25,
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.3,
      ),
      bodyLarge: base.bodyLarge?.copyWith(color: textPrimary, height: 1.35),
      bodyMedium: base.bodyMedium?.copyWith(color: textSecondary, height: 1.35),
      bodySmall: base.bodySmall?.copyWith(color: textSecondary, height: 1.35),
      labelLarge: base.labelLarge?.copyWith(
        color: textPrimary,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
    );
  }

  /// Light theme definition
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.stitchPrimary,
      brightness: Brightness.light,
      surface: AppColors.stitchSurface,
      surfaceContainerLowest: AppColors.stitchSurfaceContainerLowest,
      surfaceContainerLow: AppColors.stitchSurfaceContainerLow,
      surfaceContainer: AppColors.stitchSurfaceContainer,
      surfaceContainerHigh: AppColors.stitchSurfaceContainerHigh,
      primary: AppColors.stitchPrimary,
      primaryContainer: AppColors.stitchPrimaryContainer,
      secondary: AppColors.stitchSecondary,
      secondaryContainer: AppColors.stitchSecondaryContainer,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.stitchSurface,
      textTheme: _buildTextTheme(
        textPrimary: AppColors.stitchOnSurface,
        textSecondary: AppColors.stitchOnSurfaceVariant,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.stitchSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.stitchPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.stitchSurfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.stitchTransitHairline),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        elevation: 2,
        backgroundColor: AppColors.stitchSurface,
        indicatorColor: AppColors.stitchSurfaceContainerHigh,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 68,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.stitchPrimaryContainer,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }

  /// Dark theme definition
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
      surface: AppColors.darkSurface,
      surfaceContainerLowest: AppColors.darkBackground,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      textTheme: _buildTextTheme(
        textPrimary: AppColors.darkTextPrimary,
        textSecondary: AppColors.darkTextSecondary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkBackground,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 2,
        backgroundColor: AppColors.darkSurface,
        indicatorColor: AppColors.primaryBlue.withAlpha(60),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        height: 68,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryBlue,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
    );
  }
}
