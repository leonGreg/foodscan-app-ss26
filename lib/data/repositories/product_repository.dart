import 'package:openfoodfacts/openfoodfacts.dart' as off;
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/core/constants/additives.dart';

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
            off.ProductField.KNOWLEDGE_PANELS,
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
          final additiveData = _fetchAdditiveData(
            apiProduct.additives?.ids,
            apiProduct.knowledgePanels,
          );

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
            additivesTags: apiProduct.additives?.ids ?? [],
            labelsTags: apiProduct.labelsTags ?? [],
            nutriments: _mapNutriments(apiProduct.nutriments),
            nutrientLevels: _mapNutrientLevels(apiProduct.nutrientLevels),
            additiveDescriptions: additiveData.descriptions,
            additiveNames: additiveData.names,
            additiveRisks: additiveData.risks,
          );
        }
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  ({
    Map<String, String> names,
    Map<String, String> descriptions,
    Map<String, AdditiveRisk> risks,
  })
  _fetchAdditiveData(List<String>? tags, off.KnowledgePanels? panels) {
    final Map<String, String> names = {};
    final Map<String, String> descriptions = {};
    final Map<String, AdditiveRisk> risks = {};

    if (tags == null || tags.isEmpty) {
      return (names: names, descriptions: descriptions, risks: risks);
    }

    for (final tag in tags) {
      // 1. Try to get direct info from Knowledge Panels (additive_en:e322)
      final panelId = 'additive_$tag';
      final panel = panels?.panelIdToPanelMap[panelId];

      if (panel != null) {
        // Name (e.g., "E322 - Lecithine")
        if (panel.titleElement?.title != null) {
          names[tag] = panel.titleElement!.title!;
        }

        // Risk level from evaluation (GOOD/BAD/NEUTRAL)
        if (panel.evaluation != null) {
          switch (panel.evaluation!) {
            case off.Evaluation.GOOD:
              risks[tag] = AdditiveRisk.low;
              break;
            case off.Evaluation.BAD:
              risks[tag] = AdditiveRisk.high;
              break;
            default:
              risks[tag] = AdditiveRisk.moderate;
          }
        }

        // Keep raw HTML for better rendering with flutter_widget_from_html
        final htmlParts = panel.elements
            ?.where((e) => e.elementType == off.KnowledgePanelElementType.TEXT)
            .map((e) => e.textElement?.html)
            .where((h) => h != null && h.isNotEmpty);

        if (htmlParts != null && htmlParts.isNotEmpty) {
          descriptions[tag] = htmlParts.join('<br><br>');
        }
      }

      // 2. Fallbacks for missing panel data
      names.putIfAbsent(tag, () => tag.replaceFirst('en:', '').toUpperCase());
      risks.putIfAbsent(tag, () => AdditiveRisk.getFromTag(tag));
    }

    return (names: names, descriptions: descriptions, risks: risks);
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
