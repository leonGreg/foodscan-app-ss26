import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ScannerBottomActions extends StatelessWidget {
  final VoidCallback onManualEntry;

  const ScannerBottomActions({super.key, required this.onManualEntry});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withValues(
            alpha: AppDimensions.scannerBottomActionsOpacity,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppDimensions.borderRadiusLarge),
            topRight: Radius.circular(AppDimensions.borderRadiusLarge),
          ),
        ),
        padding: EdgeInsets.only(
          left: AppDimensions.paddingLarge,
          right: AppDimensions.paddingLarge,
          top: AppDimensions.paddingLarge,
          bottom:
              MediaQuery.of(context).padding.bottom +
              AppDimensions.paddingLarge,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Manual Entry Button
            GestureDetector(
              onTap: onManualEntry,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                decoration: BoxDecoration(
                  color: const Color(AppColors.primaryGreen),
                  borderRadius: BorderRadius.circular(
                    AppDimensions.borderRadiusMedium,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.edit, color: Colors.white),
                    const SizedBox(width: AppDimensions.paddingSmall),
                    Text(
                      localizations.enterBarcodeManually,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
