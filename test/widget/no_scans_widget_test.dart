import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/home/presentation/widgets/no_scans_widget.dart';
import 'package:food_scan/l10n/app_localizations.dart';

Widget buildTestApp(Widget child) {
  return MaterialApp(
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: child),
  );
}

void main() {
  group('NoScansWidget', () {
    testWidgets('shows empty recent scans message', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('en'));

      await tester.pumpWidget(buildTestApp(const NoScansWidget()));

      expect(find.text(l10n.noScansYet), findsOneWidget);
      expect(find.text(l10n.tapScanButtonToGetStarted), findsOneWidget);
    });

    testWidgets('shows scanner icon', (tester) async {
      await tester.pumpWidget(buildTestApp(const NoScansWidget()));

      expect(find.byIcon(Icons.qr_code_scanner_outlined), findsOneWidget);
    });
  });
}
