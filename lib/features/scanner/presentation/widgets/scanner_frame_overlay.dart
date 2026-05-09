import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class ScannerFrameOverlay extends StatelessWidget {
  final String instructionText;

  const ScannerFrameOverlay({super.key, required this.instructionText});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scanner Frame
            Container(
              width: AppDimensions.scannerFrameWidth,
              height: AppDimensions.scannerFrameHeight,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(AppColors.primaryGreen),
                  width: AppDimensions.scannerFrameBorderWidth,
                ),
                borderRadius: BorderRadius.circular(
                  AppDimensions.scannerFrameBorderRadius,
                ),
              ),
            ),
            // Instruction Text
            const SizedBox(height: AppDimensions.paddingLarge),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
              ),
              child: Text(
                instructionText,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
