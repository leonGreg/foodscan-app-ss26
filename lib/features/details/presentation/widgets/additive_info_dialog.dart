import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class AdditiveInfoDialog extends StatelessWidget {
  final String tag;
  final Product product;

  const AdditiveInfoDialog({
    super.key,
    required this.tag,
    required this.product,
  });

  static void show(BuildContext context, String tag, Product product) {
    showDialog(
      context: context,
      builder: (context) => AdditiveInfoDialog(tag: tag, product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final cleanTag = _formatTag(tag);
    final name = product.additiveNames[tag] ?? cleanTag;
    final apiDescription = product.additiveDescriptions[tag];
    final risk = product.additiveRisks[tag] ?? AdditiveRisk.getFromTag(tag);

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
          maxWidth: 400,
        ),
        child: Container(
          decoration: _dialogDecoration(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _DialogHeader(tag: cleanTag),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoSection(title: l10n.additiveName, content: name),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      _RiskSection(
                        title: l10n.riskLevel,
                        risk: risk,
                        riskText: risk.localizedName(l10n),
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      _DescriptionBox(
                        description:
                            apiDescription ?? risk.localizedDescription(l10n),
                        isHtml: apiDescription != null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTag(String tag) => tag.replaceFirst('en:', '').toUpperCase();

  BoxDecoration _dialogDecoration(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(AppDimensions.borderRadiusXLarge),
      boxShadow: [
        BoxShadow(
          color: const Color(AppColors.black).withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

extension on AdditiveRisk {
  String localizedName(AppLocalizations l10n) => switch (this) {
    AdditiveRisk.low => l10n.lowRisk,
    AdditiveRisk.moderate => l10n.moderateRisk,
    AdditiveRisk.high => l10n.highRisk,
  };

  String localizedDescription(AppLocalizations l10n) => switch (this) {
    AdditiveRisk.low => l10n.lowRiskDescription,
    AdditiveRisk.moderate => l10n.moderateRiskDescription,
    AdditiveRisk.high => l10n.highRiskDescription,
  };
}

class _DialogHeader extends StatelessWidget {
  final String tag;

  const _DialogHeader({required this.tag});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingLarge,
        left: AppDimensions.paddingLarge,
        right: AppDimensions.paddingLarge,
        bottom: AppDimensions.paddingSmall,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  tag,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.additiveInformation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(AppColors.mediumGray),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close,
                color: Color(AppColors.mediumGray),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;

  const _InfoSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        const SizedBox(height: 4),
        Text(
          content,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _RiskSection extends StatelessWidget {
  final String title;
  final AdditiveRisk risk;
  final String riskText;

  const _RiskSection({
    required this.title,
    required this.risk,
    required this.riskText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(title: title),
        const SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.circle, color: risk.color, size: 14),
            const SizedBox(width: 8),
            Text(
              riskText,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}

class _DescriptionBox extends StatelessWidget {
  final String description;
  final bool isHtml;

  const _DescriptionBox({required this.description, required this.isHtml});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge?.copyWith(
      color: const Color(AppColors.infoDarkBlue),
      height: 1.5,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: const Color(AppColors.infoLightBlue),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: isHtml
          ? HtmlWidget(description, textStyle: textStyle)
          : Text(description, style: textStyle),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: const Color(AppColors.mediumGray),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
