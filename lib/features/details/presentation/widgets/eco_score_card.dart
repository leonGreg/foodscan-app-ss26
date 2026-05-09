import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/nutrition.dart';

class EcoScoreCard extends StatelessWidget {
  final String? ecoScore;

  const EcoScoreCard({super.key, required this.ecoScore});

  EcoScore? _getEcoScore() {
    if (ecoScore == null) return null;
    try {
      return EcoScore.values.firstWhere(
        (e) => e.letter.toLowerCase() == ecoScore!.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final score = _getEcoScore();
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                  Icons.local_fire_department_outlined,
                  color: Colors.orange,
                  size: AppDimensions.iconSizeMedium,
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Text(
                  'Eco-Score',
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
            child: _buildBadge(context, score),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(BuildContext context, EcoScore? score) {
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
          'UNKNOWN',
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
