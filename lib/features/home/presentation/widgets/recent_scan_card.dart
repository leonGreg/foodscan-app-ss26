import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/core/widgets/app_card.dart';
import 'package:food_scan/core/widgets/product_image.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class RecentScanCard extends StatelessWidget {
  final String productName;
  final String barcode;
  final NutriScore? nutriScore;
  final String? imageUrl;

  const RecentScanCard({
    super.key,
    required this.productName,
    required this.barcode,
    this.nutriScore,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      child: Row(
        children: [
          ProductImage(
            imageUrl: imageUrl,
            width: AppDimensions.scanCardImageSize,
            height: AppDimensions.scanCardImageSize,
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: _ProductInfo(
              productName: productName,
              barcode: barcode,
              nutriScore: nutriScore,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final String productName;
  final String barcode;
  final NutriScore? nutriScore;

  const _ProductInfo({
    required this.productName,
    required this.barcode,
    this.nutriScore,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          productName,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          barcode,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: const Color(AppColors.mediumGray),
          ),
        ),
        const SizedBox(height: AppDimensions.paddingSmall),
        Row(
          children: [
            Text(
              l10n.nutriScore,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: const Color(AppColors.mediumGray),
              ),
            ),
            const SizedBox(width: AppDimensions.paddingSmall),
            if (nutriScore != null)
              _NutriScoreBadge(nutriScore: nutriScore!)
            else
              Text(
                l10n.unknown,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(AppColors.mediumGray),
                  fontStyle: FontStyle.italic,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _NutriScoreBadge extends StatelessWidget {
  final NutriScore nutriScore;

  const _NutriScoreBadge({required this.nutriScore});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall - 2,
        vertical: AppDimensions.paddingXSmall / 2,
      ),
      decoration: BoxDecoration(
        color: nutriScore.color,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Text(
        nutriScore.letter,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: AppDimensions.fontSizeSmall,
        ),
      ),
    );
  }
}
