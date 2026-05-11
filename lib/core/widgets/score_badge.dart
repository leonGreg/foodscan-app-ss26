import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/dimensions.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class ScoreBadge extends StatelessWidget {
  final String? letter;
  final Color? color;

  const ScoreBadge({super.key, required this.letter, required this.color});

  @override
  Widget build(BuildContext context) {
    if (letter == null || color == null) {
      final l10n = AppLocalizations.of(context)!;
      return Container(
        width: double.infinity,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
        ),
        child: Text(
          l10n.unknown.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      width: double.infinity,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.borderRadiusLarge),
      ),
      child: Text(
        letter!.toUpperCase(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
