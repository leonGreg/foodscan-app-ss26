import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/core/models/product_model.dart';

class ProductCacheRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Product?> getProduct(String barcode) async {
    final doc = await _firestore.collection('products').doc(barcode).get();
    if (!doc.exists) return null;
    return _fromFirestore(doc);
  }

  Future<void> saveProduct(Product product) async {
    await _firestore
        .collection('products')
        .doc(product.code)
        .set(_toFirestore(product));
  }

  Product _fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    ProductNutriments? nutriments;
    final nm = data['nutriments'] as Map<String, dynamic>?;
    if (nm != null) {
      nutriments = ProductNutriments(
        energyKcal100g: (nm['energyKcal100g'] as num?)?.toDouble(),
        fat100g: (nm['fat100g'] as num?)?.toDouble(),
        saturatedFat100g: (nm['saturatedFat100g'] as num?)?.toDouble(),
        carbohydrates100g: (nm['carbohydrates100g'] as num?)?.toDouble(),
        sugars100g: (nm['sugars100g'] as num?)?.toDouble(),
        proteins100g: (nm['proteins100g'] as num?)?.toDouble(),
        salt100g: (nm['salt100g'] as num?)?.toDouble(),
      );
    }

    ProductNutrientLevels? nutrientLevels;
    final nl = data['nutrientLevels'] as Map<String, dynamic>?;
    if (nl != null) {
      nutrientLevels = ProductNutrientLevels(
        fat: _nutrientLevel(nl['fat'] as String?),
        saturatedFat: _nutrientLevel(nl['saturatedFat'] as String?),
        sugars: _nutrientLevel(nl['sugars'] as String?),
        salt: _nutrientLevel(nl['salt'] as String?),
      );
    }

    final risksRaw = (data['additiveRisks'] as Map<String, dynamic>?) ?? {};
    final additiveRisks = risksRaw.map(
      (k, v) => MapEntry(k, _additiveRisk(v as String?)),
    );

    return Product(
      code: doc.id,
      productName: data['productName'] as String? ?? '',
      brands: data['brands'] as String?,
      imageFrontUrl: data['imageFrontUrl'] as String?,
      nutritionGrade: data['nutritionGrade'] as String?,
      ecoScore: data['ecoScore'] as String?,
      novaGroup: data['novaGroup'] as int?,
      ingredientsText: data['ingredientsText'] as String?,
      allergensTags: List<String>.from(data['allergensTags'] ?? []),
      categoriesTags: List<String>.from(data['categoriesTags'] ?? []),
      additivesTags: List<String>.from(data['additivesTags'] ?? []),
      labelsTags: List<String>.from(data['labelsTags'] ?? []),
      nutriments: nutriments,
      nutrientLevels: nutrientLevels,
      additiveDescriptions: Map<String, String>.from(
        data['additiveDescriptions'] ?? {},
      ),
      additiveNames: Map<String, String>.from(data['additiveNames'] ?? {}),
      additiveRisks: additiveRisks,
    );
  }

  Map<String, dynamic> _toFirestore(Product p) => {
    'productName': p.productName,
    'brands': p.brands,
    'imageFrontUrl': p.imageFrontUrl,
    'nutritionGrade': p.nutritionGrade,
    'ecoScore': p.ecoScore,
    'novaGroup': p.novaGroup,
    'ingredientsText': p.ingredientsText,
    'allergensTags': p.allergensTags,
    'categoriesTags': p.categoriesTags,
    'additivesTags': p.additivesTags,
    'labelsTags': p.labelsTags,
    'nutriments': p.nutriments == null
        ? null
        : {
            'energyKcal100g': p.nutriments!.energyKcal100g,
            'fat100g': p.nutriments!.fat100g,
            'saturatedFat100g': p.nutriments!.saturatedFat100g,
            'carbohydrates100g': p.nutriments!.carbohydrates100g,
            'sugars100g': p.nutriments!.sugars100g,
            'proteins100g': p.nutriments!.proteins100g,
            'salt100g': p.nutriments!.salt100g,
          },
    'nutrientLevels': p.nutrientLevels == null
        ? null
        : {
            'fat': p.nutrientLevels!.fat.name,
            'saturatedFat': p.nutrientLevels!.saturatedFat.name,
            'sugars': p.nutrientLevels!.sugars.name,
            'salt': p.nutrientLevels!.salt.name,
          },
    'additiveDescriptions': p.additiveDescriptions,
    'additiveNames': p.additiveNames,
    'additiveRisks': p.additiveRisks.map((k, v) => MapEntry(k, v.name)),
  };

  NutrientLevel _nutrientLevel(String? value) => NutrientLevel.values.firstWhere(
    (e) => e.name == value,
    orElse: () => NutrientLevel.unknown,
  );

  AdditiveRisk _additiveRisk(String? value) => AdditiveRisk.values.firstWhere(
    (e) => e.name == value,
    orElse: () => AdditiveRisk.moderate,
  );
}
