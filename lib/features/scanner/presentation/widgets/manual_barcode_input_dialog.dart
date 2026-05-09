import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ManualBarcodeInputDialog extends StatefulWidget {
  final AppLocalizations localizations;

  const ManualBarcodeInputDialog({
    super.key,
    required this.localizations,
  });

  @override
  State<ManualBarcodeInputDialog> createState() =>
      _ManualBarcodeInputDialogState();
}

class _ManualBarcodeInputDialogState extends State<ManualBarcodeInputDialog> {
  late TextEditingController _barcodeController;

  @override
  void initState() {
    super.initState();
    _barcodeController = TextEditingController();
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.paddingLarge,
        right: AppDimensions.paddingLarge,
        top: AppDimensions.paddingLarge,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppDimensions.paddingLarge,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              widget.localizations.enterBarcode,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            // Instructions
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              widget.localizations.enterBarcodeInstructions,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            // Input Field
            const SizedBox(height: AppDimensions.paddingMedium),
            TextField(
              controller: _barcodeController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.localizations.barcodeNumber,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppDimensions.dialogBorderRadius,
                  ),
                ),
                contentPadding: const EdgeInsets.all(
                  AppDimensions.dialogTextFieldPadding,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            // Buttons
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: _CancelButton(
                    onTap: () => Navigator.pop(context),
                    label: widget.localizations.cancel,
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(
                  child: _SearchButton(
                    onTap: () {
                      if (_barcodeController.text.isNotEmpty) {
                        Navigator.pop(context, _barcodeController.text);
                      }
                    },
                    label: widget.localizations.search,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
          ],
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _CancelButton({
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusMedium,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _SearchButton({
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(
            AppDimensions.borderRadiusMedium,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

