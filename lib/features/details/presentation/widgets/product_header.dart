import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/widgets/app_card.dart';
import 'package:food_scan/core/widgets/product_image.dart';
import 'package:food_scan/features/details/presentation/widgets/nova_badge.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ProductHeader extends StatelessWidget {
  final Product product;

  const ProductHeader({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AppCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(
            imageUrl: product.imageFrontUrl,
            width: 100,
            height: 120,
          ),
          const SizedBox(width: AppDimensions.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingSmall),
                Text(
                  '${l10n.barcode}: ${product.code}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xFF666666),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppDimensions.paddingMedium),
                NovaBadge(novaGroup: product.novaGroup),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
