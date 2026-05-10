import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ManualBarcodeInputDialog extends StatefulWidget {
  final AppLocalizations localizations;

  const ManualBarcodeInputDialog({super.key, required this.localizations});

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
        bottom:
            MediaQuery.of(context).viewInsets.bottom +
            AppDimensions.paddingLarge,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.localizations.enterBarcode,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppDimensions.paddingSmall),
            Text(
              widget.localizations.enterBarcodeInstructions,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            TextField(
              controller: _barcodeController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: widget.localizations.barcodeNumber,
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppDimensions.paddingMedium),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(widget.localizations.cancel),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingMedium),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_barcodeController.text.isNotEmpty) {
                        Navigator.pop(context, _barcodeController.text);
                      }
                    },
                    child: Text(widget.localizations.search),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
