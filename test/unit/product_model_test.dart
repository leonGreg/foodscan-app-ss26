import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/core/constants/additives.dart';
import 'package:food_scan/core/models/product_model.dart';

Product createProduct({
  String nutritionGrade = 'c',
  String? ecoScore,
  int? novaGroup,
  List<String> additivesTags = const [],
  Map<String, AdditiveRisk> additiveRisks = const {},
  List<String> labelsTags = const [],
}) => Product(
  code: '0000000000000',
  productName: 'Test Product',
  nutritionGrade: nutritionGrade,
  ecoScore: ecoScore,
  novaGroup: novaGroup,
  additivesTags: additivesTags,
  additiveRisks: additiveRisks,
  labelsTags: labelsTags,
);

void main() {
  group('Product.overallScore — NutriScore contribution', () {
    // NutriScore A is worth 30 pts on top of the 50-pt base (EcoScore unknown = 5).
    test('NutriScore A adds 30 points', () {
      final p = createProduct(nutritionGrade: 'a');
      expect(p.overallScore, 85); // 50 + 30 + 5
    });

    // Grade B contributes 20 pts.
    test('NutriScore B adds 20 points', () {
      final p = createProduct(nutritionGrade: 'b');
      expect(p.overallScore, 75); // 50 + 20 + 5
    });

    // Grade C contributes 10 pts.
    test('NutriScore C adds 10 points', () {
      final p = createProduct(nutritionGrade: 'c');
      expect(p.overallScore, 65); // 50 + 10 + 5
    });

    // Grade D contributes 5 pts.
    test('NutriScore D adds 5 points', () {
      final p = createProduct(nutritionGrade: 'd');
      expect(p.overallScore, 60); // 50 + 5 + 5
    });

    // Grade E is the worst Nutri-Score and adds nothing.
    test('NutriScore E adds 0 points', () {
      final p = createProduct(nutritionGrade: 'e');
      expect(p.overallScore, 55); // 50 + 0 + 5
    });

    // An unrecognised grade falls through to the null branch (5 pts).
    test('unknown NutriScore string adds 5 points', () {
      final p = createProduct(nutritionGrade: 'x');
      expect(p.overallScore, 60); // 50 + 5 + 5
    });
  });

  group('Product.overallScore — EcoScore contribution', () {
    // EcoScore A is the best environmental rating and adds 15 pts.
    test('EcoScore A adds 15 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a');
      expect(p.overallScore, 95); // 50 + 30 + 15
    });

    // EcoScore E is the worst and adds nothing.
    test('EcoScore E adds 0 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'e');
      expect(p.overallScore, 80); // 50 + 30 + 0
    });

    // A missing EcoScore falls back to 5 pts, same as unknown NutriScore.
    test('null EcoScore adds 5 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: null);
      expect(p.overallScore, 85); // 50 + 30 + 5
    });
  });

  group('Product.overallScore — NOVA group deduction', () {
    // NOVA 4 (ultra-processed) is penalised the most: −10 pts.
    test('NOVA 4 deducts 10 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a', novaGroup: 4);
      expect(p.overallScore, 85); // 50 + 30 + 15 - 10
    });

    // NOVA 3 (processed) costs 5 pts.
    test('NOVA 3 deducts 5 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a', novaGroup: 3);
      expect(p.overallScore, 90); // 50 + 30 + 15 - 5
    });

    // NOVA 2 (culinary ingredients) costs 2 pts.
    test('NOVA 2 deducts 2 points', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a', novaGroup: 2);
      expect(p.overallScore, 93); // 50 + 30 + 15 - 2
    });

    // NOVA 1 (unprocessed) carries no penalty.
    test('NOVA 1 deducts nothing', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a', novaGroup: 1);
      expect(p.overallScore, 95); // 50 + 30 + 15
    });
  });

  group('Product.overallScore — additive deductions', () {
    // en:e211 (sodium benzoate) is high-risk and deducts 10 pts.
    test('one high-risk additive deducts 10 points', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        additivesTags: ['en:e211'],
      );
      expect(p.overallScore, 85); // 50 + 30 + 15 - 10
    });

    // en:e955 (sucralose) is moderate-risk and deducts 2 pts.
    test('one moderate-risk additive deducts 2 points', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        additivesTags: ['en:e955'],
      );
      expect(p.overallScore, 93); // 50 + 30 + 15 - 2
    });

    // en:e330 (citric acid) is low-risk and carries no penalty.
    test('low-risk additive deducts nothing', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        additivesTags: ['en:e330'],
      );
      expect(p.overallScore, 95); // 50 + 30 + 15
    });

    // Multiple additives accumulate: 2×high (−20) + 1×moderate (−2) = −22.
    test('multiple additives accumulate correctly', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        additivesTags: ['en:e211', 'en:e211', 'en:e955'],
      );
      expect(p.overallScore, 73); // 50 + 30 + 15 - 20 - 2
    });
  });

  group('Product.overallScore — organic bonus', () {
    // A certified-organic product earns a +10 bonus; result is clamped at 100.
    test('organic label adds 10 points', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        labelsTags: ['en:organic'],
      );
      expect(p.overallScore, 100); // 105 clamped
    });

    // Unrelated labels must not trigger the organic bonus.
    test('non-organic label adds nothing', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        labelsTags: ['en:fair-trade'],
      );
      expect(p.overallScore, 95);
    });
  });

  group('Product.overallScore — clamping', () {
    // The best possible combination must not exceed 100.
    test('score is clamped to 100 maximum', () {
      final p = createProduct(
        nutritionGrade: 'a',
        ecoScore: 'a',
        novaGroup: 1,
        labelsTags: ['en:organic'],
      );
      expect(p.overallScore, 100);
    });

    // Five high-risk additives + worst grades push the raw score below zero.
    test('score is clamped to 0 minimum', () {
      final p = createProduct(
        nutritionGrade: 'e',
        ecoScore: 'e',
        novaGroup: 4,
        additivesTags: ['en:e211', 'en:e211', 'en:e211', 'en:e211', 'en:e211'],
      );
      expect(p.overallScore, 0);
    });
  });

  group('Product.overallRatingKey', () {
    // Score 95 falls in the excellent band (≥ 80).
    test('returns excellent for score >= 80', () {
      final p = createProduct(nutritionGrade: 'a', ecoScore: 'a');
      expect(p.overallRatingKey, 'excellent');
    });

    // Score 75 falls in the good band (≥ 60 and < 80).
    test('returns goodLabel for score >= 60 and < 80', () {
      final p = createProduct(nutritionGrade: 'b');
      expect(p.overallRatingKey, 'goodLabel');
    });

    // Score 50 (NutriScore E + EcoScore E) sits in the moderate band (≥ 40 and < 60).
    test('returns moderate for score >= 40 and < 60', () {
      final p = createProduct(nutritionGrade: 'e', ecoScore: 'e');
      expect(p.overallRatingKey, 'moderate');
    });

    // Score 30 (worst grades + NOVA 4 + high additive) falls in the poor band (< 40).
    test('returns poor for score < 40', () {
      final p = createProduct(
        nutritionGrade: 'e',
        ecoScore: 'e',
        novaGroup: 4,
        additivesTags: ['en:e211'],
      );
      expect(p.overallRatingKey, 'poor');
    });
  });

  group('Product.isOrganic', () {
    // The label tag must contain the word "organic" anywhere in the string.
    test('returns true when labelsTags contains organic', () {
      final p = createProduct(labelsTags: ['en:organic']);
      expect(p.isOrganic, isTrue);
    });

    // Longer compound tags that include "organic" must also match.
    test('returns true for partial match like ab-agriculture-biologique', () {
      final p = createProduct(
        labelsTags: ['en:ab-agriculture-biologique-organic'],
      );
      expect(p.isOrganic, isTrue);
    });

    // A product with no labels at all is not organic.
    test('returns false when labelsTags is empty', () {
      final p = createProduct(labelsTags: []);
      expect(p.isOrganic, isFalse);
    });

    // Unrelated certifications must not be mistaken for organic.
    test('returns false for unrelated labels', () {
      final p = createProduct(labelsTags: ['en:fair-trade', 'en:gluten-free']);
      expect(p.isOrganic, isFalse);
    });
  });

  group('AdditiveRisk.getFromTag', () {
    // The en: prefix is stripped before lookup; e211 is high-risk.
    test('correctly identifies high-risk additive', () {
      expect(AdditiveRisk.getFromTag('en:e211'), AdditiveRisk.high);
    });

    // e955 (sucralose) is in the moderate-risk mapping.
    test('correctly identifies moderate-risk additive', () {
      expect(AdditiveRisk.getFromTag('en:e955'), AdditiveRisk.moderate);
    });

    // e330 (citric acid) is in the low-risk mapping.
    test('correctly identifies low-risk additive', () {
      expect(AdditiveRisk.getFromTag('en:e330'), AdditiveRisk.low);
    });

    // Any tag not in the mapping defaults to moderate, not low.
    test('unknown tag defaults to moderate', () {
      expect(AdditiveRisk.getFromTag('en:e999'), AdditiveRisk.moderate);
    });

    // Tags without a language prefix must also resolve correctly.
    test('tag without en: prefix is handled', () {
      expect(AdditiveRisk.getFromTag('e211'), AdditiveRisk.high);
    });
  });
}
