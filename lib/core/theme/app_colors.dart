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
}
