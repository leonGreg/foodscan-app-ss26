import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NoScansWidget extends StatelessWidget {
  const NoScansWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: AppDimensions.paddingXLarge),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.qr_code_scanner_outlined,
              size: AppDimensions.iconSizeXLarge,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          Text(
            localizations.noScansYet,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: AppDimensions.paddingMedium),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium,
            ),
            child: Text(
              localizations.tapScanButtonToGetStarted,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
