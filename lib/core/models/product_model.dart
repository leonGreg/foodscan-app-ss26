import 'package:flutter/material.dart';
import '../constants/additives.dart';
import '../../config/constants/colors.dart';

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

  bool get isOrganic => labelsTags.any((tag) => tag.contains('organic'));

  int get overallScore {
    double score = 0;

    // 1. Nutri-Score (60%)
    double nutriScorePoints = 0;
    switch (nutritionGrade?.toLowerCase()) {
      case 'a':
        nutriScorePoints = 100;
        break;
      case 'b':
        nutriScorePoints = 80;
        break;
      case 'c':
        nutriScorePoints = 60;
        break;
      case 'd':
        nutriScorePoints = 40;
        break;
      case 'e':
        nutriScorePoints = 20;
        break;
      default:
        nutriScorePoints = 50; // Neutral for unknown
    }
    score += nutriScorePoints * 0.6;

    // 2. Additives (30%)
    double additiveScore = 100;
    if (additivesTags.isNotEmpty) {
      double totalDeduction = 0;
      for (final tag in additivesTags) {
        final risk = additiveRisks[tag] ?? AdditiveRisk.low;

        if (risk == AdditiveRisk.high) {
          totalDeduction += 25;
        } else if (risk == AdditiveRisk.moderate) {
          totalDeduction += 10;
        }
      }
      additiveScore = (100 - totalDeduction).clamp(0, 100).toDouble();
    }
    score += additiveScore * 0.3;

    // 3. Bio (10%)
    double bioScore = isOrganic ? 100 : 0;
    score += bioScore * 0.1;

    return score.round();
  }

  String get overallRatingKey {
    final score = overallScore;
    if (score >= 80) return 'excellent';
    if (score >= 60) return 'goodLabel';
    if (score >= 40) return 'moderate';
    return 'poor';
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
