import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';

class RatingBadge extends StatelessWidget {
  final String text;
  final Color color;
  final bool useSolidBackground;

  const RatingBadge({
    super.key,
    required this.text,
    required this.color,
    this.useSolidBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingSmall,
        vertical: AppDimensions.paddingXSmall / 2,
      ),
      decoration: BoxDecoration(
        color: useSolidBackground ? color : color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: useSolidBackground ? Colors.white : color,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
