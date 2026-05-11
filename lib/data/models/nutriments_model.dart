import 'package:food_scan/core/models/product_model.dart';

class NutrimentsModel {
  const NutrimentsModel({
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

  factory NutrimentsModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const NutrimentsModel();
    }

    return NutrimentsModel(
      energyKcal100g: _toDouble(json['energy-kcal_100g']),
      fat100g: _toDouble(json['fat_100g']),
      saturatedFat100g: _toDouble(json['saturated-fat_100g']),
      carbohydrates100g: _toDouble(json['carbohydrates_100g']),
      sugars100g: _toDouble(json['sugars_100g']),
      proteins100g: _toDouble(json['proteins_100g']),
      salt100g: _toDouble(json['salt_100g']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'energy-kcal_100g': energyKcal100g,
      'fat_100g': fat100g,
      'saturated-fat_100g': saturatedFat100g,
      'carbohydrates_100g': carbohydrates100g,
      'sugars_100g': sugars100g,
      'proteins_100g': proteins100g,
      'salt_100g': salt100g,
    };
  }

  /// Convert to domain entity
  ProductNutriments toDomainEntity() {
    return ProductNutriments(
      energyKcal100g: energyKcal100g,
      fat100g: fat100g,
      saturatedFat100g: saturatedFat100g,
      carbohydrates100g: carbohydrates100g,
      sugars100g: sugars100g,
      proteins100g: proteins100g,
      salt100g: salt100g,
    );
  }

  /// Create from domain entity
  factory NutrimentsModel.fromDomainEntity(ProductNutriments nutriments) {
    return NutrimentsModel(
      energyKcal100g: nutriments.energyKcal100g,
      fat100g: nutriments.fat100g,
      saturatedFat100g: nutriments.saturatedFat100g,
      carbohydrates100g: nutriments.carbohydrates100g,
      sugars100g: nutriments.sugars100g,
      proteins100g: nutriments.proteins100g,
      salt100g: nutriments.salt100g,
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }
}
