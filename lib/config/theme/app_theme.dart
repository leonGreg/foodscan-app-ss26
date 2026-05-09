import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
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
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
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
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
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
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.borderGray)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.borderGray)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(
            color: Color(AppColors.primaryGreen),
            width: 2,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(AppColors.mediumGray),
      ),
    );
  }
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
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
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
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
            borderRadius:
                BorderRadius.circular(AppDimensions.borderRadiusMedium),
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
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.surfaceDark)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(color: Color(AppColors.surfaceDark)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.borderRadiusMedium),
          borderSide: const BorderSide(
            color: Color(AppColors.primaryGreen),
            width: 2,
          ),
        ),
      ),
      iconTheme: const IconThemeData(
        color: Colors.grey,
      ),
    );
  }
}

