import 'package:flutter/material.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/config/constants/colors.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class Product {
  const Product({
    required this.code,
    required this.productName,
    this.brands,
    this.imageFrontUrl,
    this.nutritionGrade,
    this.ecoScore,
    this.novaGroup,
    this.ingredientsText,
    this.allergensTags = const [],
    this.categoriesTags = const [],
    this.additivesTags = const [],
    this.labelsTags = const [],
    this.nutriments,
    this.nutrientLevels,
    this.additiveDescriptions = const {},
    this.additiveNames = const {},
    this.additiveRisks = const {},
  });

  final String code;
  final String productName;
  final String? brands;
  final String? imageFrontUrl;
  final String? nutritionGrade;
  final String? ecoScore;
  final int? novaGroup;
  final String? ingredientsText;
  final List<String> allergensTags;
  final List<String> categoriesTags;
  final List<String> additivesTags;
  final List<String> labelsTags;
  final ProductNutriments? nutriments;
  final ProductNutrientLevels? nutrientLevels;
  final Map<String, String> additiveDescriptions;
  final Map<String, String> additiveNames;
  final Map<String, AdditiveRisk> additiveRisks;

  NutriScore? get nutriScoreEnum => NutriScore.fromString(nutritionGrade);

  EcoScore? get ecoScoreEnum => EcoScore.fromString(ecoScore);

  bool get isOrganic => labelsTags.any((tag) => tag.contains('organic'));

  ScoreBreakdown calculateScoreBreakdown(AppLocalizations l10n) {
    final components = <ScoreComponent>[];

    // 1. Base Score
    components.add(
      ScoreComponent(
        title: l10n.baseScore,
        subtitle: l10n.baseScoreSubtitle,
        points: 50,
      ),
    );

    // 2. Nutri-Score
    int nutriPoints = switch (nutriScoreEnum) {
      NutriScore.a => 30,
      NutriScore.b => 20,
      NutriScore.c => 10,
      NutriScore.d => 5,
      NutriScore.e => 0,
      null => 5,
    };
    components.add(
      ScoreComponent(
        title: l10n.nutriScore,
        subtitle: l10n.nutriScoreSubtitle(
          nutritionGrade?.toUpperCase() ?? l10n.unknown,
        ),
        points: nutriPoints,
      ),
    );

    // 3. Eco-Score
    int ecoPoints = switch (ecoScoreEnum) {
      EcoScore.a => 15,
      EcoScore.b => 10,
      EcoScore.c => 5,
      EcoScore.d => 2,
      EcoScore.e => 0,
      null => 5,
    };
    components.add(
      ScoreComponent(
        title: l10n.ecoScore,
        subtitle: l10n.ecoScoreSubtitle(
          ecoScore?.toUpperCase() ?? l10n.unknown,
        ),
        points: ecoPoints,
      ),
    );

    // 4. Additives
    int highRisk = 0;
    int moderateRisk = 0;
    for (final tag in additivesTags) {
      final risk = additiveRisks[tag] ?? AdditiveRisk.getFromTag(tag);
      if (risk == AdditiveRisk.high) highRisk++;
      if (risk == AdditiveRisk.moderate) moderateRisk++;
    }
    int additiveDeduction = (highRisk * 10) + (moderateRisk * 2);
    if (additiveDeduction > 0) {
      components.add(
        ScoreComponent(
          title: l10n.additivesLabel,
          subtitle: l10n.additivesSubtitle(highRisk, moderateRisk),
          points: -additiveDeduction,
          isPositive: false,
        ),
      );
    }

    // 5. NOVA Group
    int novaDeduction = switch (novaGroup) {
      4 => 10,
      3 => 5,
      2 => 2,
      _ => 0,
    };
    if (novaDeduction > 0) {
      components.add(
        ScoreComponent(
          title: '${l10n.novaGroup} $novaGroup',
          subtitle: novaGroup == 4
              ? l10n.novaSubtitleUltra
              : l10n.novaSubtitleProcessed,
          points: -novaDeduction,
          isPositive: false,
        ),
      );
    }

    // 6. Bio Bonus
    if (isOrganic) {
      components.add(
        ScoreComponent(
          title: l10n.organicBonus,
          subtitle: l10n.organicBonusSubtitle,
          points: 10,
        ),
      );
    }

    int total = components.fold(0, (sum, item) => sum + item.points);
    return ScoreBreakdown(
      totalScore: total.clamp(0, 100),
      components: components,
    );
  }

  int get overallScore {
    int total = 50; // Base

    total += switch (nutriScoreEnum) {
      NutriScore.a => 30,
      NutriScore.b => 20,
      NutriScore.c => 10,
      NutriScore.d => 5,
      NutriScore.e => 0,
      null => 5,
    };

    total += switch (ecoScoreEnum) {
      EcoScore.a => 15,
      EcoScore.b => 10,
      EcoScore.c => 5,
      EcoScore.d => 2,
      EcoScore.e => 0,
      null => 5,
    };

    int highRisk = 0;
    int moderateRisk = 0;
    for (final tag in additivesTags) {
      final risk = additiveRisks[tag] ?? AdditiveRisk.getFromTag(tag);
      if (risk == AdditiveRisk.high) highRisk++;
      if (risk == AdditiveRisk.moderate) moderateRisk++;
    }
    total -= (highRisk * 10) + (moderateRisk * 2);

    total -= switch (novaGroup) {
      4 => 10,
      3 => 5,
      2 => 2,
      _ => 0,
    };

    if (isOrganic) total += 10;

    return total.clamp(0, 100);
  }

  String get overallRatingKey {
    final score = overallScore;
    if (score >= 80) return 'excellent';
    if (score >= 60) return 'goodLabel';
    if (score >= 40) return 'moderate';
    return 'poor';
  }

  static Color getScoreColor(int score) {
    if (score >= 80) return Colors.green;
    if (score >= 60) return Colors.lightGreen;
    if (score >= 40) return Colors.orange;
    return Colors.red;
  }

  static String getRatingText(String key, AppLocalizations l10n) {
    return switch (key) {
      'excellent' => l10n.excellent,
      'goodLabel' => l10n.goodLabel,
      'moderate' => l10n.moderate,
      'poor' => l10n.poor,
      _ => l10n.unknown,
    };
  }
}

class ProductNutriments {
  const ProductNutriments({
    this.energyKcal100g,
    this.fat100g,
    this.saturatedFat100g,
    this.carbohydrates100g,
    this.sugars100g,
    this.proteins100g,
    this.salt100g,
  });

  final double? energyKcal100g;
  final double? fat100g;
  final double? saturatedFat100g;
  final double? carbohydrates100g;
  final double? sugars100g;
  final double? proteins100g;
  final double? salt100g;
}

enum NutrientLevel {
  low(Color(AppColors.successGreen)),
  moderate(Color(AppColors.warningOrange)),
  high(Color(AppColors.dangerRed)),
  unknown(Colors.grey);

  final Color color;

  const NutrientLevel(this.color);
}

class ProductNutrientLevels {
  const ProductNutrientLevels({
    this.fat = NutrientLevel.unknown,
    this.saturatedFat = NutrientLevel.unknown,
    this.sugars = NutrientLevel.unknown,
    this.salt = NutrientLevel.unknown,
  });

  final NutrientLevel fat;
  final NutrientLevel saturatedFat;
  final NutrientLevel sugars;
  final NutrientLevel salt;
}

class ScoreBreakdown {
  final int totalScore;
  final List<ScoreComponent> components;

  ScoreBreakdown({required this.totalScore, required this.components});
}

class ScoreComponent {
  final String title;
  final String subtitle;
  final int points;
  final bool isPositive;

  ScoreComponent({
    required this.title,
    required this.subtitle,
    required this.points,
    this.isPositive = true,
  });
}
