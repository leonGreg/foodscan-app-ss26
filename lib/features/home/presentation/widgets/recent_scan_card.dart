import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/strings.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class RecentScanCard extends StatelessWidget {
  final String productName;
  final String barcode;
  final NutriScore nutriScore;
  final String? imageUrl;

  const RecentScanCard({
    super.key,
    required this.productName,
    required this.barcode,
    required this.nutriScore,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      padding: const EdgeInsets.all(AppDimensions.paddingSmall),
      decoration: BoxDecoration(
        color: Color(AppColors.white),
        border: Border.all(
          color: const Color(AppColors.borderGray).withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: AppDimensions.shadowBlurRadius,
            offset: const Offset(0, AppDimensions.shadowOffsetY),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: AppDimensions.scanCardImageSize,
            height: AppDimensions.scanCardImageSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusMedium,
              ),
              color: const Color(AppColors.lightGray),
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: NetworkImage(AppStrings.placeholderImageUrl),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  barcode,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color(AppColors.mediumGray),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Row(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.nutriScore,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Color(AppColors.mediumGray),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall - 2, // 6
                        vertical: AppDimensions.paddingXSmall / 2, // 2
                      ),
                      decoration: BoxDecoration(
                        color: nutriScore.color,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusSmall,
                        ),
                      ),
                      child: Text(
                        nutriScore.letter,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: AppDimensions.fontSizeSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
