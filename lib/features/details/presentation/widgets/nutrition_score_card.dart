import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NutritionScoreCard extends StatelessWidget {
  final Product product;

  const NutritionScoreCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    final overallScore = product.overallScore;
    final ratingKey = product.overallRatingKey;

    String ratingText = '';
    switch (ratingKey) {
      case 'excellent':
        ratingText = localizations.excellent;
        break;
      case 'goodLabel':
        ratingText = localizations.goodLabel;
        break;
      case 'moderate':
        ratingText = localizations.moderate;
        break;
      case 'poor':
        ratingText = localizations.poor;
        break;
      default:
        ratingText = localizations.unknown;
    }

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
                    color: const Color(AppColors.mediumGray),
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
                            color: _getScoreColor(overallScore),
                          ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: AppDimensions.paddingXSmall / 2,
                      ),
                      decoration: BoxDecoration(
                        color: _getScoreColor(
                          overallScore,
                        ).withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusSmall,
                        ),
                      ),
                      child: Text(
                        ratingText,
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: _getScoreColor(overallScore),
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
                  backgroundColor: _getScoreColor(
                    overallScore,
                  ).withValues(alpha: 0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getScoreColor(overallScore),
                  ),
                  strokeCap: StrokeCap.round,
                ),
                Center(
                  child: Text(
                    '$overallScore',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(overallScore),
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

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }
}
