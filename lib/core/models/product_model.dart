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
    this.nutriments,
    this.nutrientLevels,
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
  final ProductNutriments? nutriments;
  final ProductNutrientLevels? nutrientLevels;
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

enum NutrientLevel { low, moderate, high, unknown }

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
