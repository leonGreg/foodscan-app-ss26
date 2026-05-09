import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/models/product_model.dart';

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
    return Column(
      children: [
        _buildTabSwitcher(),
        const SizedBox(height: AppDimensions.paddingMedium),
        _selectedIndex == 0
            ? _buildAdditivesList(widget.product.additivesTags)
            : _buildNutritionTable(widget.product.nutriments),
      ],
    );
  }

  Widget _buildTabSwitcher() {
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
          Expanded(child: _buildTabItem(0, 'Additives')),
          Expanded(child: _buildTabItem(1, 'Nutrition')),
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

  Widget _buildAdditivesList(List<String> additives) {
    if (additives.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text('No additives found'),
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
        final additive = additives[index].replaceAll('en:', '').toUpperCase();
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
                    additive,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.circle, color: Colors.orange, size: 8),
                ],
              ),
            ),
            title: Text(
              additive,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
            onTap: () {
              // Handle tap
            },
          ),
        );
      },
    );
  }

  Widget _buildNutritionTable(ProductNutriments? nutriments) {
    if (nutriments == null) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text('No nutrition data found'),
        ),
      );
    }

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
            'Nutritional Values (per 100g)',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),
          _buildNutritionRow(
            'Energy',
            '${nutriments.energyKcal100g?.toStringAsFixed(0) ?? '-'} kcal',
            Colors.red,
          ),
          _buildNutritionRow(
            'Fat',
            '${nutriments.fat100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.red,
          ),
          _buildNutritionRow(
            'Saturated Fat',
            '${nutriments.saturatedFat100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.red,
            isIndented: true,
          ),
          _buildNutritionRow(
            'Carbohydrates',
            '${nutriments.carbohydrates100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.grey,
          ),
          _buildNutritionRow(
            'Sugars',
            '${nutriments.sugars100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.red,
            isIndented: true,
          ),
          _buildNutritionRow(
            'Proteins',
            '${nutriments.proteins100g?.toStringAsFixed(1) ?? '-'} g',
            Colors.orange,
          ),
          _buildNutritionRow(
            'Salt',
            '${nutriments.salt100g?.toStringAsFixed(2) ?? '-'} g',
            Colors.green,
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
