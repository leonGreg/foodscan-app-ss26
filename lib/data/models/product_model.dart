import 'package:food_scan/core/models/product_model.dart';
import 'nutriments_model.dart';

class ProductModel {
  const ProductModel({
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
    this.nutriments = const NutrimentsModel(),
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
  final List<String> labelsTags;
  final NutrimentsModel nutriments;
  final ProductNutrientLevels? nutrientLevels;

  /// Convert to domain entity
  Product toDomainEntity() {
    return Product(
      code: code,
      productName: productName,
      brands: brands,
      imageFrontUrl: imageFrontUrl,
      nutritionGrade: nutritionGrade,
      ecoScore: ecoScore,
      novaGroup: novaGroup,
      ingredientsText: ingredientsText,
      allergensTags: allergensTags,
      categoriesTags: categoriesTags,
      additivesTags: additivesTags,
      labelsTags: labelsTags,
      nutriments: nutriments.toDomainEntity(),
      nutrientLevels: nutrientLevels,
    );
  }

  /// Create from domain entity
  factory ProductModel.fromDomainEntity(Product product) {
    return ProductModel(
      code: product.code,
      productName: product.productName,
      brands: product.brands,
      imageFrontUrl: product.imageFrontUrl,
      nutritionGrade: product.nutritionGrade,
      ecoScore: product.ecoScore,
      novaGroup: product.novaGroup,
      ingredientsText: product.ingredientsText,
      allergensTags: product.allergensTags,
      categoriesTags: product.categoriesTags,
      additivesTags: product.additivesTags,
      labelsTags: product.labelsTags,
      nutriments: product.nutriments != null
          ? NutrimentsModel.fromDomainEntity(product.nutriments!)
          : const NutrimentsModel(),
      nutrientLevels: product.nutrientLevels,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      code: (json['code'] ?? '').toString(),
      productName: _readProductName(json),
      brands: _readNullableString(json['brands']),
      imageFrontUrl: _readNullableString(json['image_front_url']),
      nutritionGrade: _readNullableString(json['nutrition_grades']),
      ecoScore: _readNullableString(json['ecoscore_grade']),
      novaGroup: json['nova_group'] as int?,
      ingredientsText: _readNullableString(json['ingredients_text']),
      allergensTags: _readStringList(json['allergens_tags']),
      categoriesTags: _readStringList(json['categories_tags']),
      additivesTags: _readStringList(json['additives_tags']),
      labelsTags: _readStringList(json['labels_tags']),
      nutriments: NutrimentsModel.fromJson(
        json['nutriments'] is Map<String, dynamic>
            ? json['nutriments'] as Map<String, dynamic>
            : null,
      ),
      nutrientLevels: _parseNutrientLevels(json['nutrient_levels']),
    );
  }

  static ProductNutrientLevels? _parseNutrientLevels(dynamic json) {
    if (json is! Map) return null;
    return ProductNutrientLevels(
      fat: _parseLevel(json['fat']),
      saturatedFat: _parseLevel(json['saturated-fat']),
      sugars: _parseLevel(json['sugars']),
      salt: _parseLevel(json['salt']),
    );
  }

  static NutrientLevel _parseLevel(dynamic value) {
    switch (value?.toString().toLowerCase()) {
      case 'low':
        return NutrientLevel.low;
      case 'moderate':
        return NutrientLevel.moderate;
      case 'high':
        return NutrientLevel.high;
      default:
        return NutrientLevel.unknown;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'product_name': productName,
      'brands': brands,
      'image_front_url': imageFrontUrl,
      'nutrition_grades': nutritionGrade,
      'ecoscore_grade': ecoScore,
      'nova_group': novaGroup,
      'ingredients_text': ingredientsText,
      'allergens_tags': allergensTags,
      'categories_tags': categoriesTags,
      'additives_tags': additivesTags,
      'labels_tags': labelsTags,
      'nutriments': nutriments.toJson(),
      'nutrient_levels': nutrientLevels != null ? {
        'fat': nutrientLevels!.fat.name,
        'saturated-fat': nutrientLevels!.saturatedFat.name,
        'sugars': nutrientLevels!.sugars.name,
        'salt': nutrientLevels!.salt.name,
      } : null,
    };
  }

  static String _readProductName(Map<String, dynamic> json) {
    final name = _readNullableString(json['product_name']);
    if (name != null && name.isNotEmpty) return name;
    return 'Unknown product';
  }

  static String? _readNullableString(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static List<String> _readStringList(dynamic value) {
    if (value is List) {
      return value.map((item) => item.toString()).toList();
    }
    return const [];
  }
}
