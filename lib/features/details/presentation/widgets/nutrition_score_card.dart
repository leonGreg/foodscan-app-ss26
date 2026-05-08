import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NutritionScoreCard extends StatelessWidget {
  final String? nutritionGrade;

  const NutritionScoreCard({super.key, required this.nutritionGrade});

  NutriScore? _getNutriScore() {
    if (nutritionGrade == null) return null;
    try {
      return NutriScore.values.firstWhere(
        (e) => e.letter.toLowerCase() == nutritionGrade!.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nutriScore = _getNutriScore();
    final localizations = AppLocalizations.of(context)!;

    // Get overall rating score (mock data - in this case 61)
    final overallScore = 61;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.surfaceLight),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: Border.all(
          color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.overallRating,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color(AppColors.mediumGray),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Row(
                  children: [
                    Text(
                      '$overallScore/100',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: nutriScore?.color,
                          ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: AppDimensions.paddingXSmall / 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            nutriScore?.color.withValues(alpha: 0.2) ??
                            Colors.grey.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusSmall,
                        ),
                      ),
                      child: Text(
                        'Moderate', // TODO: Get localized rating text
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: nutriScore?.color ?? Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Circular score indicator
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: overallScore / 100,
                  strokeWidth: 8,
                  backgroundColor: (nutriScore?.color ?? Colors.grey)
                      .withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    nutriScore?.color ?? Colors.grey,
                  ),
                  strokeCap: StrokeCap.round,
                ),
                Center(
                  child: Text(
                    '$overallScore',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: nutriScore?.color,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
