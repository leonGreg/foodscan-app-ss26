import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/core/widgets/info_card.dart';
import 'package:food_scan/core/widgets/score_badge.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class NutriScoreBadge extends StatelessWidget {
  final String? nutritionGrade;

  const NutriScoreBadge({super.key, required this.nutritionGrade});

  @override
  Widget build(BuildContext context) {
    final score = NutriScore.fromString(nutritionGrade);
    final l10n = AppLocalizations.of(context)!;

    return InfoCard(
      title: l10n.nutriScore,
      icon: Icons.eco_outlined,
      iconColor: Colors.green,
      child: ScoreBadge(
        letter: score?.letter,
        color: score?.color,
      ),
    );
  }
}
