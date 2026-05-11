import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/widgets/app_card.dart';
import 'package:food_scan/l10n/app_localizations.dart';

import 'package:food_scan/core/widgets/rating_badge.dart';
import 'package:food_scan/features/details/presentation/widgets/score_breakdown_dialog.dart';

class NutritionScoreCard extends StatelessWidget {
  final Product product;

  const NutritionScoreCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final overallScore = product.overallScore;
    final ratingText = Product.getRatingText(product.overallRatingKey, l10n);
    final scoreColor = Product.getScoreColor(overallScore);

    return AppCard(
      onTap: () => ScoreBreakdownDialog.show(context, product),
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
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
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: scoreColor,
                          ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    RatingBadge(text: ratingText, color: scoreColor),
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
