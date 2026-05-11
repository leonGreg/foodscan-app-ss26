import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/widgets/rating_badge.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ScoreBreakdownDialog extends StatelessWidget {
  final Product product;

  const ScoreBreakdownDialog({super.key, required this.product});

  static void show(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => ScoreBreakdownDialog(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final breakdown = product.calculateScoreBreakdown(l10n);
    final ratingText = Product.getRatingText(product.overallRatingKey, l10n);
    final scoreColor = Product.getScoreColor(breakdown.totalScore);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingLarge),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DialogHeader(l10n: l10n),
            const SizedBox(height: AppDimensions.paddingMedium),
            _TotalScoreCard(
              score: breakdown.totalScore,
              ratingText: ratingText,
              scoreColor: scoreColor,
              l10n: l10n,
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: breakdown.components.length,
                separatorBuilder: (context, index) => const Divider(height: 20),
                itemBuilder: (context, index) {
                  final component = breakdown.components[index];
                  return _ComponentRow(component: component, l10n: l10n);
                },
              ),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            _RatingScaleCard(l10n: l10n),
          ],
        ),
      ),
    );
  }
}

class _DialogHeader extends StatelessWidget {
  final AppLocalizations l10n;

  const _DialogHeader({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.scoreBreakdown,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.howWeCalculated,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(AppColors.mediumGray),
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 20),
          onPressed: () => Navigator.pop(context),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}

class _TotalScoreCard extends StatelessWidget {
  final int score;
  final String ratingText;
  final Color scoreColor;
  final AppLocalizations l10n;

  const _TotalScoreCard({
    required this.score,
    required this.ratingText,
    required this.scoreColor,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.lightGray).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: Column(
        children: [
          Text(
            l10n.totalScore,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(AppColors.mediumGray),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$score',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '/100',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: const Color(
                    AppColors.mediumGray,
                  ).withValues(alpha: 0.6),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          RatingBadge(
            text: ratingText,
            color: scoreColor,
            useSolidBackground: true,
          ),
        ],
      ),
    );
  }
}

class _ComponentRow extends StatelessWidget {
  final ScoreComponent component;
  final AppLocalizations l10n;

  const _ComponentRow({required this.component, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final pointsText = component.points > 0
        ? '+${component.points}'
        : '${component.points}';
    final pointsColor = component.points >= 0 ? Colors.green : Colors.red;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                component.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                component.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(AppColors.mediumGray),
                ),
              ),
            ],
          ),
        ),
        Text(
          pointsText,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: pointsColor,
          ),
        ),
      ],
    );
  }
}

class _RatingScaleCard extends StatelessWidget {
  final AppLocalizations l10n;

  const _RatingScaleCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: const Color(AppColors.infoLightBlue).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.gradeClassifications,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: const Color(AppColors.infoDarkBlue),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _ScaleItem(
            color: Colors.green,
            label: '${l10n.excellent}: 80-100 ${l10n.points}',
          ),
          const SizedBox(height: 4),
          _ScaleItem(
            color: Colors.lightGreen,
            label: '${l10n.goodLabel}: 60-79 ${l10n.points}',
          ),
          const SizedBox(height: 4),
          _ScaleItem(
            color: Colors.orange,
            label: '${l10n.moderate}: 40-59 ${l10n.points}',
          ),
          const SizedBox(height: 4),
          _ScaleItem(
            color: Colors.red,
            label: '${l10n.poor}: 0-39 ${l10n.points}',
          ),
        ],
      ),
    );
  }
}

class _ScaleItem extends StatelessWidget {
  final Color color;
  final String label;

  const _ScaleItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 10),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(AppColors.infoDarkBlue),
          ),
        ),
      ],
    );
  }
}
