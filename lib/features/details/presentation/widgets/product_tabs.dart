import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:food_scan/features/details/presentation/widgets/additive_info_dialog.dart';

class ProductTabs extends StatefulWidget {
  final Product product;

  const ProductTabs({super.key, required this.product});

  @override
  State<ProductTabs> createState() => _ProductTabsState();
}

class _ProductTabsState extends State<ProductTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _buildTabSwitcher(l10n),
        const SizedBox(height: AppDimensions.paddingMedium),
        _selectedIndex == 0
            ? _buildAdditivesList(widget.product.additivesTags, l10n)
            : _buildNutritionTable(widget.product.nutriments, l10n),
      ],
    );
  }

  Widget _buildTabSwitcher(AppLocalizations l10n) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDarkMode
            ? const Color(AppColors.surfaceDark)
            : const Color(0xFFE0E0E0).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXXLarge),
      ),
      child: Row(
        children: [
          Expanded(child: _buildTabItem(0, l10n.additives)),
          Expanded(child: _buildTabItem(1, l10n.nutrition)),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    final isSelected = _selectedIndex == index;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDarkMode ? Colors.grey[800] : Colors.white)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusXXLarge,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? (isDarkMode ? Colors.white : Colors.black)
                : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildAdditivesList(List<String> additives, AppLocalizations l10n) {
    if (additives.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text(l10n.noAdditivesFound),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      itemCount: additives.length,
      itemBuilder: (context, index) {
        final tag = additives[index];
        final additiveName = tag.replaceAll('en:', '').toUpperCase();
        final risk = AdditiveRisk.getFromTag(tag);

        return Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusLarge,
            ),
            border: Border.all(
              color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
            ),
          ),
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    additiveName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.circle, color: risk.color, size: 8),
                ],
              ),
            ),
            title: Text(
              additiveName,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () => AdditiveInfoDialog.show(context, tag, widget.product),
          ),
        );
      },
    );
  }

  Widget _buildNutritionTable(
    ProductNutriments? nutriments,
    AppLocalizations l10n,
  ) {
    if (nutriments == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text(l10n.noNutritionDataFound),
        ),
      );
    }

    final levels = widget.product.nutrientLevels;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
      ),
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        border: Border.all(
          color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.nutritionalValuesPer100g,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildNutritionRow(
            l10n.energy,
            '${nutriments.energyKcal100g?.toStringAsFixed(0) ?? '-'} kcal',
            Colors.grey, // Energy doesn't have a level
          ),
          _buildNutritionRow(
            l10n.fat,
            '${nutriments.fat100g?.toStringAsFixed(1) ?? '-'} g',
            levels?.fat.color ?? Colors.grey,
          ),
          _buildNutritionRow(
            l10n.saturatedFat,
            '${nutriments.saturatedFat100g?.toStringAsFixed(1) ?? '-'} g',
            levels?.saturatedFat.color ?? Colors.grey,
            isIndented: true,
          ),
          _buildNutritionRow(
            l10n.carbohydrates,
            '${nutriments.carbohydrates100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.grey, // Carbohydrates don't have a level
          ),
          _buildNutritionRow(
            l10n.sugars,
            '${nutriments.sugars100g?.toStringAsFixed(1) ?? '-'} g',
            levels?.sugars.color ?? Colors.grey,
            isIndented: true,
          ),
          _buildNutritionRow(
            l10n.proteins,
            '${nutriments.proteins100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.grey, // Proteins don't have a level
          ),
          _buildNutritionRow(
            l10n.salt,
            '${nutriments.salt100g?.toStringAsFixed(2) ?? '-'} g',
            levels?.salt.color ?? Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionRow(
    String label,
    String value,
    Color statusColor, {
    bool isIndented = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: AppDimensions.paddingSmall,
        left: isIndented ? AppDimensions.paddingMedium : 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
          ),
          Row(
            children: [
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              Icon(Icons.circle, color: statusColor, size: 12),
            ],
          ),
        ],
      ),
    );
  }
}
