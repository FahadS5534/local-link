import 'package:flutter/material.dart';

/// Design tokens and semantic brand colors for Mumbai Suburban Railway corridors.
abstract final class AppColors {
  // Line Corridor Accents
  static const Color westernLine = Color(0xFFDC2626); // Red / Crimson
  static const Color centralLine = Color(0xFF2563EB); // Royal Blue
  static const Color harbourLine = Color(0xFFD97706); // Amber / Ochre
  static const Color transHarbourLine = Color(0xFF0D9488); // Teal
  static const Color uranLine = Color(0xFF7C3AED); // Purple

  // Primary Theme Colors (Modern Mumbai Local theme)
  static const Color primaryBlue = Color(0xFF1D4ED8);
  static const Color primaryDark = Color(0xFF1E3A8A);

  // Status & Freshness Indicators
  static const Color freshReportGreen = Color(0xFF16A34A);
  static const Color expiringReportAmber = Color(0xFFEAB308);
  static const Color expiredReportGray = Color(0xFF9CA3AF);

  // Fast vs Slow Service Badges
  static const Color fastTrainBadge = Color(0xFFDC2626); // Fast indicator
  static const Color slowTrainBadge = Color(0xFF4B5563); // Slow indicator
  static const Color acTrainBadge = Color(0xFF0284C7); // AC Local cyan-blue

  // Neutral Tones - Light Mode
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);

  // Neutral Tones - Dark Mode
  static const Color darkBackground = Color(0xFF0B1120);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkBorder = Color(0xFF334155);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Stitch Design Tokens (Project 3963698584923642931 / DESIGN.md)
  static const Color stitchPrimary = Color(0xFF04335B); // Deep Railway Navy
  static const Color stitchPrimaryContainer = Color(0xFF244A73);
  static const Color stitchSecondary = Color(0xFFAC332B); // Crimson Red
  static const Color stitchSecondaryContainer = Color(0xFFFD6E60);
  static const Color stitchSecondaryFixed = Color(0xFFFFDAD5);
  static const Color stitchSurface = Color(0xFFF9F9FF);
  static const Color stitchSurfaceDim = Color(0xFFCCDBF8);
  static const Color stitchSurfaceContainer = Color(0xFFE7EEFF);
  static const Color stitchSurfaceContainerLow = Color(0xFFF0F3FF);
  static const Color stitchSurfaceContainerHigh = Color(0xFFDEE8FF);
  static const Color stitchSurfaceContainerHighest = Color(0xFFD5E3FF);
  static const Color stitchSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color stitchOnSurface = Color(0xFF0C1C31);
  static const Color stitchOnSurfaceVariant = Color(0xFF43474E);
  static const Color stitchTertiary = Color(0xFF003B22);
  static const Color stitchTertiaryContainer = Color(0xFF005433);
  static const Color stitchTertiaryFixed = Color(0xFFA6F3C4);
  static const Color stitchTransitHairline = Color(0xFFE4E2DC);
  static const Color stitchPrimaryInk = Color(0xFF17263C);
  static const Color stitchCentralOrange = Color(0xFFF28C28);
  static const Color stitchHarbourCyan = Color(0xFF0284C7);
  static const Color stitchTransHarbourPurple = Color(0xFF7C3AED);
  static const Color stitchSuccessTrack = Color(0xFF26734D);
  static const Color stitchWarningIndicator = Color(0xFFA86417);
  static const Color stitchCriticalAlert = Color(0xFFB42318);
  static const Color stitchInverseSurface = Color(0xFF223147);
  static const Color stitchInverseOnSurface = Color(0xFFEBF1FF);
  static const Color stitchOutline = Color(0xFF73777F);
  static const Color stitchOutlineVariant = Color(0xFFC3C6CF);
  static const Color stitchSurfaceTint = Color(0xFF3C608B);
}
