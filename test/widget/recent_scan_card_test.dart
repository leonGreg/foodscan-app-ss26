import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/config/constants/nutrition.dart';
import 'package:food_scan/features/home/presentation/widgets/recent_scan_card.dart';
import 'package:food_scan/l10n/app_localizations.dart';

Widget buildTestApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  group('RecentScanCard', () {
    // The product name is the primary label and must always be visible.
    testWidgets('displays the product name', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const RecentScanCard(
            productName: 'Organic Oat Milk',
            barcode: '4012345678901',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Organic Oat Milk'), findsOneWidget);
    });

    // The barcode is shown as secondary info below the product name.
    testWidgets('displays the barcode', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const RecentScanCard(
            productName: 'Test Product',
            barcode: '1234567890123',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('1234567890123'), findsOneWidget);
    });

    // When a NutriScore is present the corresponding letter badge must render.
    testWidgets('displays NutriScore badge when provided', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const RecentScanCard(
            productName: 'Healthy Cereal',
            barcode: '9876543210987',
            nutriScore: NutriScore.a,
          ),
        ),
      );
      await tester.pump();

      expect(find.text('A'), findsOneWidget);
    });

    // Without a NutriScore no letter badge must appear; the fallback text is shown instead.
    testWidgets('shows unknown label when NutriScore is null', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const RecentScanCard(
            productName: 'Mystery Food',
            barcode: '0000000000001',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('A'), findsNothing);
      expect(find.text('B'), findsNothing);
      // The localised "Unknown" text is rendered in place of the badge.
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));
      expect(find.text(l10n.unknown), findsOneWidget);
    });

    // A null imageUrl must not crash the widget — it falls back to a placeholder.
    testWidgets('renders without errors when imageUrl is null', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          const RecentScanCard(
            productName: 'No Image Product',
            barcode: '1111111111111',
          ),
        ),
      );
      await tester.pump();

      expect(find.text('No Image Product'), findsOneWidget);
    });
  });
}
