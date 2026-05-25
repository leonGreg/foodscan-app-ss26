import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/widgets/app_card.dart';
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
        _TabSwitcher(
          selectedIndex: _selectedIndex,
          labels: [l10n.additives, l10n.nutrition],
          onChanged: (index) => setState(() => _selectedIndex = index),
        ),
        const SizedBox(height: AppDimensions.paddingMedium),
        _selectedIndex == 0
            ? _AdditivesList(product: widget.product)
            : _NutritionTable(product: widget.product),
      ],
    );
  }
}

class _TabSwitcher extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final ValueChanged<int> onChanged;

  const _TabSwitcher({
    required this.selectedIndex,
    required this.labels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
        children: List.generate(labels.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(index),
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
                  labels[index],
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected
                        ? (isDarkMode ? Colors.white : Colors.black)
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _AdditivesList extends StatelessWidget {
  final Product product;

  const _AdditivesList({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final additives = product.additivesTags;

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
        final formattedTag = AdditiveRisk.formatTag(tag);
        final risk = AdditiveRisk.getFromTag(tag);

        return AppCard(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
          padding: EdgeInsets.zero,
          onTap: () => AdditiveInfoDialog.show(context, tag, product),
          child: ListTile(
            leading: _TagBadge(tag: formattedTag, riskColor: risk.color),
            title: Text(
              product.additiveNames[tag] ?? formattedTag,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          ),
        );
      },
    );
  }
}

class _TagBadge extends StatelessWidget {
  final String tag;
  final Color riskColor;

  const _TagBadge({required this.tag, required this.riskColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 4),
          Icon(Icons.circle, color: riskColor, size: 8),
        ],
      ),
    );
  }
}

class _NutritionTable extends StatelessWidget {
  final Product product;

  const _NutritionTable({required this.product});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nutriments = product.nutriments;
    final levels = product.nutrientLevels;

    if (nutriments == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingLarge),
          child: Text(l10n.noNutritionDataFound),
        ),
      );
    }

    return AppCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLarge,
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
          _NutritionRow(
            label: l10n.energy,
            value:
                '${nutriments.energyKcal100g?.toStringAsFixed(0) ?? '-'} kcal',
            statusColor: Colors.grey,
          ),
          _NutritionRow(
            label: l10n.fat,
            value: '${nutriments.fat100g?.toStringAsFixed(1) ?? '-'} g',
            statusColor: levels?.fat.color ?? Colors.grey,
          ),
          _NutritionRow(
            label: l10n.saturatedFat,
            value:
                '${nutriments.saturatedFat100g?.toStringAsFixed(1) ?? '-'} g',
            statusColor: levels?.saturatedFat.color ?? Colors.grey,
            isIndented: true,
          ),
          _NutritionRow(
            label: l10n.carbohydrates,
            value:
                '${nutriments.carbohydrates100g?.toStringAsFixed(1) ?? '-'} g',
            statusColor: Colors.grey,
          ),
          _NutritionRow(
            label: l10n.sugars,
            value: '${nutriments.sugars100g?.toStringAsFixed(1) ?? '-'} g',
            statusColor: levels?.sugars.color ?? Colors.grey,
            isIndented: true,
          ),
          _NutritionRow(
            label: l10n.proteins,
            value: '${nutriments.proteins100g?.toStringAsFixed(1) ?? '-'} g',
            statusColor: Colors.grey,
          ),
          _NutritionRow(
            label: l10n.salt,
            value: '${nutriments.salt100g?.toStringAsFixed(2) ?? '-'} g',
            statusColor: levels?.salt.color ?? Colors.grey,
          ),
        ],
      ),
    );
  }
}

class _NutritionRow extends StatelessWidget {
  final String label;
  final String value;
  final Color statusColor;
  final bool isIndented;

  const _NutritionRow({
    required this.label,
    required this.value,
    required this.statusColor,
    this.isIndented = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimensions.paddingSmall),
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
