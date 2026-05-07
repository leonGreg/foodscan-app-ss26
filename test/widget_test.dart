import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/app/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const FoodScanApp());

    // Verify the app is built
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
