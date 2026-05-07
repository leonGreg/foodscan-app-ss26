class Product {
  const Product({
    required this.code,
    required this.productName,
    this.brands,
    this.imageFrontUrl,
    this.nutritionGrade,
    this.ingredientsText,
    this.allergensTags = const [],
    this.categoriesTags = const [],
    this.nutriments,
  });

  final String code;
  final String productName;
  final String? brands;
  final String? imageFrontUrl;
  final String? nutritionGrade;
  final String? ingredientsText;
  final List<String> allergensTags;
  final List<String> categoriesTags;
  final ProductNutriments? nutriments;
}

class ProductNutriments {
  const ProductNutriments({
    this.energyKcal100g,
    this.fat100g,
    this.sugars100g,
    this.salt100g,
  });

  final double? energyKcal100g;
  final double? fat100g;
  final double? sugars100g;
  final double? salt100g;
}

