import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/strings.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/details/presentation/widgets/nova_badge.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(AppColors.surfaceDark)
            : const Color(AppColors.white),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: Border.all(
          color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image (Left)
          Container(
            width: 100,
            height: 120,
            decoration: BoxDecoration(
              color: const Color(AppColors.lightGray),
              borderRadius: BorderRadius.circular(
                AppDimensions.borderRadiusMedium,
              ),
              image: product.imageFrontUrl != null && product.imageFrontUrl!.isNotEmpty
                  ? DecorationImage(
                      image: NetworkImage(product.imageFrontUrl!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: AssetImage(AppStrings.noImagePlaceholder),
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          // Product Info (Right)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  product.productName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                // Barcode
                Text(
                  '${l10n.barcode}: ${product.code}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(AppColors.mediumGray),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                // NOVA Badge
                NovaBadge(novaGroup: product.novaGroup),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
