import 'nutriments_model.dart';

class ProductModel {
  const ProductModel({
    required this.code,
    required this.productName,
    this.brands,
    this.imageFrontUrl,
    this.nutritionGrade,
    this.ingredientsText,
    this.allergensTags = const [],
    this.categoriesTags = const [],
    this.nutriments = const NutrimentsModel(),
  });

  final String code;
  final String productName;
  final String? brands;
  final String? imageFrontUrl;
  final String? nutritionGrade;
  final String? ingredientsText;
  final List<String> allergensTags;
  final List<String> categoriesTags;
  final NutrimentsModel nutriments;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      code: (json['code'] ?? '').toString(),
      productName: _readProductName(json),
      brands: _readNullableString(json['brands']),
      imageFrontUrl: _readNullableString(json['image_front_url']),
      nutritionGrade: _readNullableString(json['nutrition_grades']),
      ingredientsText: _readNullableString(json['ingredients_text']),
      allergensTags: _readStringList(json['allergens_tags']),
      categoriesTags: _readStringList(json['categories_tags']),
      nutriments: NutrimentsModel.fromJson(
        json['nutriments'] is Map<String, dynamic>
            ? json['nutriments'] as Map<String, dynamic>
            : null,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'product_name': productName,
      'brands': brands,
      'image_front_url': imageFrontUrl,
      'nutrition_grades': nutritionGrade,
      'ingredients_text': ingredientsText,
      'allergens_tags': allergensTags,
      'categories_tags': categoriesTags,
      'nutriments': nutriments.toJson(),
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
