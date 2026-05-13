import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    setupFirebaseCoreMocks();
    await Firebase.initializeApp();
  });

  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const FoodScanApp());
    await tester.pump();

    expect(find.byType(FoodScanApp), findsOneWidget);
  });
}
