import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/widgets/app_card.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NutritionScoreCard extends StatelessWidget {
  final Product product;

  const NutritionScoreCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final overallScore = product.overallScore;
    final ratingText = _getRatingText(product.overallRatingKey, l10n);
    final scoreColor = _getScoreColor(overallScore);

    return AppCard(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingLarge),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.overallRating,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(AppColors.mediumGray),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Row(
                  children: [
                    Text(
                      '$overallScore/100',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scoreColor,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    _RatingBadge(text: ratingText, color: scoreColor),
                  ],
                ),
              ],
            ),
          ),
          _CircularScoreIndicator(score: overallScore, color: scoreColor),
        ],
      ),
    );
  }

  String _getRatingText(String key, AppLocalizations l10n) {
    return switch (key) {
      'excellent' => l10n.excellent,
      'goodLabel' => l10n.goodLabel,
      'moderate' => l10n.moderate,
      'poor' => l10n.poor,
      _ => l10n.unknown,
    };
  }

  Color _getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }
}

class _RatingBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _RatingBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingXSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _CircularScoreIndicator extends StatelessWidget {
  final int score;
  final Color color;

  const _CircularScoreIndicator({required this.score, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircularProgressIndicator(
            value: score / 100,
            strokeWidth: 8,
            backgroundColor: color.withValues(alpha: 0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            strokeCap: StrokeCap.round,
          ),
          Center(
            child: Text(
              '$score',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
