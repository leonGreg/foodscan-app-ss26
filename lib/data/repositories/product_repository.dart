import 'package:openfoodfacts/openfoodfacts.dart' as off;
import 'package:food_scan/core/models/product_model.dart';

class ProductRepository {
  Future<Product?> getProduct(String barcode) async {
    final off.ProductQueryConfiguration configuration =
        off.ProductQueryConfiguration(
          barcode,
          language: off.OpenFoodFactsLanguage.GERMAN,
          fields: [
            off.ProductField.BARCODE,
            off.ProductField.NAME,
            off.ProductField.BRANDS,
            off.ProductField.IMAGE_FRONT_URL,
            off.ProductField.NUTRISCORE,
            off.ProductField.ECOSCORE_GRADE,
            off.ProductField.NOVA_GROUP,
            off.ProductField.INGREDIENTS_TEXT,
            off.ProductField.ALLERGENS,
            off.ProductField.CATEGORIES_TAGS,
            off.ProductField.ADDITIVES,
            off.ProductField.NUTRIMENTS,
            off.ProductField.NUTRIENT_LEVELS,
            off.ProductField.LABELS_TAGS,
          ],
          version: off.ProductQueryVersion.v3,
        );

    try {
      final off.ProductResultV3 result =
          await off.OpenFoodAPIClient.getProductV3(configuration);

      if (result.status == off.ProductResultV3.statusSuccess ||
          result.product != null) {
        final apiProduct = result.product;
        if (apiProduct != null) {
          return Product(
            code: apiProduct.barcode ?? barcode,
            productName: apiProduct.productName ?? 'Unknown Product',
            brands: apiProduct.brands,
            imageFrontUrl: apiProduct.imageFrontUrl,
            nutritionGrade: apiProduct.nutriscore?.toUpperCase(),
            ecoScore: apiProduct.ecoscoreGrade?.toUpperCase(),
            novaGroup: apiProduct.novaGroup,
            ingredientsText: apiProduct.ingredientsText,
            allergensTags: apiProduct.allergens?.names ?? [],
            categoriesTags: apiProduct.categoriesTags ?? [],
            additivesTags: apiProduct.additives?.names ?? [],
            labelsTags: apiProduct.labelsTags ?? [],
            nutriments: _mapNutriments(apiProduct.nutriments),
            nutrientLevels: _mapNutrientLevels(apiProduct.nutrientLevels),
          );
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  ProductNutriments? _mapNutriments(off.Nutriments? nutriments) {
    if (nutriments == null) return null;

    return ProductNutriments(
      energyKcal100g: nutriments.getValue(
        off.Nutrient.energyKCal,
        off.PerSize.oneHundredGrams,
      ),
      fat100g: nutriments.getValue(
        off.Nutrient.fat,
        off.PerSize.oneHundredGrams,
      ),
      saturatedFat100g: nutriments.getValue(
        off.Nutrient.saturatedFat,
        off.PerSize.oneHundredGrams,
      ),
      carbohydrates100g: nutriments.getValue(
        off.Nutrient.carbohydrates,
        off.PerSize.oneHundredGrams,
      ),
      sugars100g: nutriments.getValue(
        off.Nutrient.sugars,
        off.PerSize.oneHundredGrams,
      ),
      proteins100g: nutriments.getValue(
        off.Nutrient.proteins,
        off.PerSize.oneHundredGrams,
      ),
      salt100g: nutriments.getValue(
        off.Nutrient.salt,
        off.PerSize.oneHundredGrams,
      ),
    );
  }

  ProductNutrientLevels? _mapNutrientLevels(off.NutrientLevels? levels) {
    if (levels == null) return null;

    return ProductNutrientLevels(
      fat: _toNutrientLevel(levels.levels[off.NutrientLevels.NUTRIENT_FAT]),
      saturatedFat: _toNutrientLevel(
        levels.levels[off.NutrientLevels.NUTRIENT_SATURATED_FAT],
      ),
      sugars: _toNutrientLevel(
        levels.levels[off.NutrientLevels.NUTRIENT_SUGARS],
      ),
      salt: _toNutrientLevel(levels.levels[off.NutrientLevels.NUTRIENT_SALT]),
    );
  }

  NutrientLevel _toNutrientLevel(off.NutrientLevel? level) {
    if (level == null) return NutrientLevel.unknown;
    switch (level) {
      case off.NutrientLevel.LOW:
        return NutrientLevel.low;
      case off.NutrientLevel.MODERATE:
        return NutrientLevel.moderate;
      case off.NutrientLevel.HIGH:
        return NutrientLevel.high;
      default:
        return NutrientLevel.unknown;
    }
  }
}
