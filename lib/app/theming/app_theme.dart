import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme = ThemeData(
    brightness: .dark,
    scaffoldBackgroundColor: AppColors.darkBlue,
    textTheme: TextTheme(
      bodyLarge: AppTypography.bodyLarge,
      bodySmall: AppTypography.bodySmall,
      bodyMedium: AppTypography.bodyMedium,
      titleLarge: AppTypography.titleLarge,
      titleSmall: AppTypography.titleSmall,
      labelSmall: AppTypography.labelSmall,
      labelLarge: AppTypography.labelLarge,
      titleMedium: AppTypography.titleMedium,
      labelMedium: AppTypography.labelMedium,
      displaySmall: AppTypography.displaySmall,
      displayLarge: AppTypography.displayLarge,
      headlineLarge: AppTypography.headlineLarge,
      displayMedium: AppTypography.displayMedium,
      headlineSmall: AppTypography.headlineSmall,
      headlineMedium: AppTypography.headlineMedium,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      labelStyle: AppTypography.titleMedium.copyWith(color: AppColors.white),
      fillColor: AppColors.lightDarkBlue,
      border: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.white),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.white),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.white),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: .circular(12),
        borderSide: BorderSide(color: AppColors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.darkBlue,
        padding: .symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: .circular(48)),
      ),
    ),
  );
}
