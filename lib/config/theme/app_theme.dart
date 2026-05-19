import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(AppColors.primaryGreen),
      ).copyWith(
        surface: Color(AppColors.backgroundLight),
        surfaceContainerLowest: Color(0xFFFFFFFF),
        surfaceContainerLow: Color(0xFFF9F9F9),
        surfaceContainer: Color(AppColors.surfaceLight),
        surfaceContainerHigh: Color(0xFFEEEEEE),
        surfaceContainerHighest: Color(AppColors.borderGray),
        surfaceTint: Colors.transparent,
      ),
      primaryColor: Color(AppColors.primaryGreen),
      scaffoldBackgroundColor: Color(AppColors.backgroundLight),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(AppColors.primaryGreen),
        foregroundColor: Color(AppColors.white),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: AppDimensions.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.white),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppDimensions.fontSizeDisplayMedium,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.darkGray),
        ),
        displayMedium: TextStyle(
          fontSize: AppDimensions.fontSizeDisplaySmall,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.darkGray),
        ),
        headlineSmall: TextStyle(
          fontSize: AppDimensions.fontSizeHeadline,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.darkGray),
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSizeLarge,
          color: Color(AppColors.darkGray),
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          color: Color(AppColors.mediumGray),
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontSizeSmall,
          color: Color(AppColors.mediumGray),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppColors.primaryGreen),
          foregroundColor: Color(AppColors.white),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(AppColors.primaryGreen),
          side: const BorderSide(color: Color(AppColors.primaryGreen)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        fillColor: Color(AppColors.white),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.borderGray)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.borderGray)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(
            color: Color(AppColors.primaryGreen),
            width: 2,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Color(AppColors.mediumGray)),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(AppColors.primaryGreen),
        brightness: Brightness.dark,
      ).copyWith(
        surface: Color(AppColors.backgroundDark),
        surfaceContainerLowest: Color(0xFF141414),
        surfaceContainerLow: Color(AppColors.backgroundDark),
        surfaceContainer: Color(0xFF242424),
        surfaceContainerHigh: Color(AppColors.surfaceDark),
        surfaceContainerHighest: Color(0xFF3A3A3A),
        surfaceTint: Colors.transparent,
      ),
      primaryColor: Color(AppColors.primaryGreen),
      scaffoldBackgroundColor: Color(AppColors.backgroundDark),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(AppColors.primaryDarkGreen),
        foregroundColor: Color(AppColors.white),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: const TextStyle(
          fontSize: AppDimensions.fontSizeXLarge,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.white),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: AppDimensions.fontSizeDisplayMedium,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.white),
        ),
        displayMedium: TextStyle(
          fontSize: AppDimensions.fontSizeDisplaySmall,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.white),
        ),
        headlineSmall: TextStyle(
          fontSize: AppDimensions.fontSizeHeadline,
          fontWeight: FontWeight.bold,
          color: Color(AppColors.white),
        ),
        bodyLarge: TextStyle(
          fontSize: AppDimensions.fontSizeLarge,
          color: Color(AppColors.white),
        ),
        bodyMedium: TextStyle(
          fontSize: AppDimensions.fontSizeMedium,
          color: Color(AppColors.lightGray),
        ),
        bodySmall: TextStyle(
          fontSize: AppDimensions.fontSizeSmall,
          color: Color(AppColors.lightGray),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(AppColors.primaryGreen),
          foregroundColor: Color(AppColors.white),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Color(AppColors.primaryGreen),
          side: const BorderSide(color: Color(AppColors.primaryGreen)),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.buttonPaddingHorizontal,
            vertical: AppDimensions.buttonPaddingVertical,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusMedium,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingMedium,
          vertical: AppDimensions.paddingSmall,
        ),
        fillColor: Color(AppColors.surfaceDark),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.surfaceDark)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.surfaceDark)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(
            color: Color(AppColors.primaryGreen),
            width: 2,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.grey),
    );
  }
}
