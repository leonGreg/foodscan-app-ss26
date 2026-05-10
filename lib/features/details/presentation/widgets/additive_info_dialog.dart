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
    final name =
        product.additiveNames[tag] ?? tag.replaceFirst('en:', '').toUpperCase();
    final apiDescription = product.additiveDescriptions[tag];
    final risk = product.additiveRisks[tag] ?? AdditiveRisk.getFromTag(tag);
    final tagUpper = tag.replaceFirst('en:', '').toUpperCase();

    String riskText;
    switch (risk) {
      case AdditiveRisk.low:
        riskText = l10n.lowRisk;
        break;
      case AdditiveRisk.moderate:
        riskText = l10n.moderateRisk;
        break;
      case AdditiveRisk.high:
        riskText = l10n.highRisk;
        break;
    }

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
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(
              AppDimensions.borderRadiusXLarge,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(AppColors.black).withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Fixed Header
              Padding(
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
                            tagUpper,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            l10n.additiveInformation,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
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
              ),

              // Scrollable Content
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(AppDimensions.paddingLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle(l10n.additiveName, context),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      _buildSectionTitle(l10n.riskLevel, context),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.circle, color: risk.color, size: 14),
                          const SizedBox(width: 8),
                          Text(
                            riskText,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppDimensions.paddingLarge),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          AppDimensions.paddingMedium,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(AppColors.infoLightBlue),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusLarge,
                          ),
                        ),
                        child: apiDescription != null
                            ? HtmlWidget(
                                apiDescription,
                                textStyle: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: const Color(
                                        AppColors.infoDarkBlue,
                                      ),
                                      height: 1.5,
                                    ),
                              )
                            : Text(
                                _getFallbackDescription(risk, l10n),
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: const Color(
                                        AppColors.infoDarkBlue,
                                      ),
                                      height: 1.5,
                                    ),
                              ),
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

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: const Color(AppColors.mediumGray),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  String _getFallbackDescription(AdditiveRisk risk, AppLocalizations l10n) {
    switch (risk) {
      case AdditiveRisk.low:
        return l10n.lowRiskDescription;
      case AdditiveRisk.moderate:
        return l10n.moderateRiskDescription;
      case AdditiveRisk.high:
        return l10n.highRiskDescription;
    }
  }
}
