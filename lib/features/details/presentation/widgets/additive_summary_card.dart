import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class AdditiveSummaryCard extends StatefulWidget {
  final List<String> additives;

  const AdditiveSummaryCard({super.key, required this.additives});

  @override
  State<AdditiveSummaryCard> createState() => _AdditiveSummaryCardState();
}

class _AdditiveSummaryCardState extends State<AdditiveSummaryCard> {
  late int _highRiskCount;
  late int _moderateRiskCount;
  late int _lowRiskCount;

  @override
  void initState() {
    super.initState();
    _countAdditivesByRisk();
  }

  void _countAdditivesByRisk() {
    _highRiskCount = 0;
    _moderateRiskCount = 0;
    _lowRiskCount = 0;

    for (final tag in widget.additives) {
      final risk = AdditiveRisk.getFromTag(tag);
      switch (risk) {
        case AdditiveRisk.high:
          _highRiskCount++;
          break;
        case AdditiveRisk.moderate:
          _moderateRiskCount++;
          break;
        case AdditiveRisk.low:
          _lowRiskCount++;
          break;
      }
    }
  }

  void _showAdditiveDetailsBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.7,
          maxChildSize: 0.9,
          minChildSize: 0.5,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: _buildBottomSheetContent(),
            );
          },
        );
      },
    );
  }

  Widget _buildBottomSheetContent() {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDarkMode
          ? const Color(AppColors.surfaceDark)
          : const Color(AppColors.surfaceLight),
      padding: const EdgeInsets.all(AppDimensions.paddingLarge),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.additives,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingLarge),

          // Summary stats
          if (widget.additives.isNotEmpty) ...[
            _buildStatRow(
              l10n.total,
              widget.additives.length.toString(),
              Colors.grey,
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildStatRow(
              '${l10n.highRisk} (${l10n.avoid})',
              _highRiskCount.toString(),
              const Color(AppColors.dangerRed),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildStatRow(
              '${l10n.moderateRisk} (${l10n.limit})',
              _moderateRiskCount.toString(),
              const Color(AppColors.warningOrange),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            _buildStatRow(
              '${l10n.lowRisk} (${l10n.safe})',
              _lowRiskCount.toString(),
              const Color(AppColors.successGreen),
            ),
            const SizedBox(height: AppDimensions.paddingLarge),
            Divider(
              color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
          ],

          // Additives list
          if (widget.additives.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                child: Text(l10n.noAdditivesFound),
              ),
            )
          else
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.additives.length,
              itemBuilder: (context, index) {
                final tag = widget.additives[index];
                final additiveName = tag.replaceAll('en:', '').toUpperCase();
                final risk = AdditiveRisk.getFromTag(tag);

                return Container(
                  margin: const EdgeInsets.only(
                    bottom: AppDimensions.paddingSmall,
                  ),
                  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.borderRadiusLarge,
                    ),
                    border: Border.all(
                      color: risk.color.withValues(alpha: 0.3),
                    ),
                    color: risk.color.withValues(alpha: 0.05),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: risk.color.withValues(alpha: 0.2),
                        ),
                        child: Icon(
                          Icons.warning_outlined,
                          color: risk.color,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.paddingMedium),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              additiveName,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getRiskLabel(risk, l10n),
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: risk.color,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingSmall,
                          vertical: AppDimensions.paddingXSmall,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall,
                          ),
                          color: risk.color.withValues(alpha: 0.15),
                        ),
                        child: Text(
                          tag.replaceAll('en:', ''),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(
                                color: risk.color,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingXSmall,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusSmall,
            ),
            color: color.withValues(alpha: 0.15),
          ),
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  String _getRiskLabel(AdditiveRisk risk, AppLocalizations l10n) {
    switch (risk) {
      case AdditiveRisk.high:
        return l10n.highRisk;
      case AdditiveRisk.moderate:
        return l10n.moderateRisk;
      case AdditiveRisk.low:
        return l10n.lowRisk;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.additives.isEmpty) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: _showAdditiveDetailsBottomSheet,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingLarge,
        ),
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: isDarkMode
              ? const Color(AppColors.surfaceDark)
              : const Color(AppColors.surfaceLight),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
          border: Border.all(
            color: const Color(AppColors.borderGray).withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_outlined,
                  color: const Color(AppColors.warningOrange),
                  size: 24,
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Text(
                  l10n.additives,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _buildRiskBadge(
                    l10n.high,
                    _highRiskCount,
                    const Color(AppColors.dangerRed),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: _buildRiskBadge(
                    l10n.moderate,
                    _moderateRiskCount,
                    const Color(AppColors.warningOrange),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingSmall),
                Expanded(
                  child: _buildRiskBadge(
                    l10n.low,
                    _lowRiskCount,
                    const Color(AppColors.successGreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${l10n.total}: ${widget.additives.length}',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
                Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskBadge(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingXSmall,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        color: color.withValues(alpha: 0.15),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
