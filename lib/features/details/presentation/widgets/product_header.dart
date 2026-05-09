import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/config/constants/strings.dart';
import 'package:food_scan/core/models/product_model.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
              image: product.imageFrontUrl != null
                  ? DecorationImage(
                      image: NetworkImage(product.imageFrontUrl!),
                      fit: BoxFit.cover,
                    )
                  : const DecorationImage(
                      image: NetworkImage(AppStrings.placeholderImageUrl),
                      fit: BoxFit.cover,
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
                  'Barcode: ${product.code}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Color(AppColors.mediumGray),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                // NOVA Badge and Category
                Row(
                  children: [
                    // NOVA Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: AppDimensions.paddingXSmall / 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusSmall,
                        ),
                      ),
                      child: Text(
                        'NOVA 4',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    // Ultra-processed Text
                    Expanded(
                      child: Text(
                        'Ultra-processed',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color(AppColors.mediumGray),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
