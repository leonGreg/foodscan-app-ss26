import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zxing/flutter_zxing.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';
import 'package:food_scan/features/scanner/presentation/bloc/scanner_bloc.dart';
import 'package:food_scan/features/scanner/presentation/widgets/scanner_app_bar.dart';
import 'package:food_scan/features/scanner/presentation/widgets/scanner_frame_overlay.dart';
import 'package:food_scan/features/scanner/presentation/widgets/scanner_bottom_actions.dart';
import 'package:food_scan/features/scanner/presentation/widgets/manual_barcode_input_dialog.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  bool hasScanned = false;

  void _onScan(Code result) {
    if (!hasScanned && mounted && result.isValid && result.text != null) {
      hasScanned = true;
      context.read<ScannerBloc>().add(BarcodeDetectedEvent(result.text!));
    }
  }

  void _showManualBarcodeEntry(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final bloc = context.read<ScannerBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppDimensions.bottomSheetBorderRadius),
          topRight: Radius.circular(AppDimensions.bottomSheetBorderRadius),
        ),
      ),
      builder: (context) =>
          ManualBarcodeInputDialog(localizations: localizations),
    ).then((result) {
      if (result != null && result is String && mounted) {
        hasScanned = true;
        bloc.add(BarcodeDetectedEvent(result));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocListener<ScannerBloc, ScannerState>(
        listener: (context, state) {
          if (state is ScannerBarcodeDetected) {
            Navigator.of(context).pop(state.barcode);
          } else if (state is ScannerError) {
            // TODO: Show error message to user
          }
        },
        child: Stack(
          children: [
            // Camera View
            ReaderWidget(
              onScan: _onScan,
              showScannerOverlay: false,
              showFlashlight: false,
              showToggleCamera: false,
              showGallery: false,
              codeFormat: Format.ean13 | Format.ean8,
            ),
            // Top App Bar
            ScannerAppBar(title: localizations.scanProduct),
            // Scanner Frame Overlay
            ScannerFrameOverlay(instructionText: localizations.positionBarcode),

            ScannerBottomActions(
              onManualEntry: () => _showManualBarcodeEntry(context),
            ),
          ],
        ),
      ),
    );
  }
}
