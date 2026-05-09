import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NutriScoreBadge extends StatelessWidget {
  final String? nutritionGrade;

  const NutriScoreBadge({super.key, required this.nutritionGrade});

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
    final score = _getNutriScore();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.surfaceLight),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: Border.all(
          color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.eco_outlined,
                  color: Colors.green,
                  size: 20,
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Text(
                  l10n.nutriScore,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color(AppColors.mediumGray),
                      ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: AppDimensions.paddingMedium,
              right: AppDimensions.paddingMedium,
              bottom: AppDimensions.paddingLarge,
            ),
            child: _buildBadge(context, score, l10n),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, NutriScore? score, AppLocalizations l10n) {
    if (score == null) {
      return Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        child: Text(
          l10n.unknown.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: score.color,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: Text(
        score.letter.toUpperCase(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
