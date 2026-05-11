import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/core/widgets/info_card.dart';
import 'package:food_scan/core/widgets/score_badge.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class EcoScoreCard extends StatelessWidget {
  final String? ecoScore;

  const EcoScoreCard({super.key, required this.ecoScore});

  @override
  Widget build(BuildContext context) {
    final score = EcoScore.fromString(ecoScore);
    final l10n = AppLocalizations.of(context)!;

    return InfoCard(
      title: l10n.ecoScore,
      icon: Icons.local_fire_department_outlined,
      iconColor: Colors.orange,
      child: ScoreBadge(letter: score?.letter, color: score?.color),
    );
  }
}
