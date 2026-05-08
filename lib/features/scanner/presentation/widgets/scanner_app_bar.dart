import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class ScannerAppBar extends StatelessWidget {
  final String title;

  const ScannerAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(
          top: AppDimensions.appBarTopPadding,
          left: AppDimensions.paddingLarge,
          right: AppDimensions.paddingLarge,
          bottom: AppDimensions.paddingLarge,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Back Button
            GestureDetector(
              onTap: () => context.pop(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(
                    alpha: AppDimensions.scannerAppBarOpacity,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: AppDimensions.scannerTopBarBackButtonSize,
                ),
              ),
            ),
            // Title
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Spacer for alignment
            const SizedBox(width: AppDimensions.scannerTopBarSpacerWidth),
          ],
        ),
      ),
    );
  }
}

