import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_scan/features/auth/data/models/user_model.dart';
import 'package:food_scan/features/auth/data/services/auth_service_base.dart';
import 'package:food_scan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:food_scan/features/auth/presentation/pages/login_page.dart';
import 'package:food_scan/l10n/app_localizations.dart';

class FakeAuthService extends AuthServiceBase {
  @override
  Stream<User?> get authStateChanges => const Stream.empty();

  @override
  User? get currentFirebaseUser => null;

  @override
  Future<AppUser> signInWithEmail(String email, String password) async =>
      AppUser(
        uid: 'uid',
        email: email,
        displayName: 'User',
        createdAt: DateTime(2024),
      );

  @override
  Future<AppUser> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
  }) async => AppUser(
    uid: 'uid',
    email: email,
    displayName: displayName,
    createdAt: DateTime(2024),
  );

  @override
  Future<void> signOut() async {}

  @override
  Future<void> sendPasswordResetEmail(String email) async {}
}

Widget buildLoginPage() {
  return BlocProvider(
    create: (_) => AuthBloc(authService: FakeAuthService()),
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginPage(),
    ),
  );
}

void main() {
  group('LoginPage', () {
    // The form must expose exactly two text fields: email and password.
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    // A single submit button must be present in the initial state.
    testWidgets('renders a submit button', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    // Submitting with both fields empty must show the email-required error.
    testWidgets('shows email validation error on empty submit', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Email is required'), findsOneWidget);
    });

    // Submitting with both fields empty must show the password-required error.
    testWidgets('shows password validation error on empty submit', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Password is required'), findsOneWidget);
    });

    // A string without a valid email structure must show the format error.
    testWidgets('shows email format error for invalid email', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).first, 'notanemail');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Enter a valid email address'), findsOneWidget);
    });

    // A password below 6 characters must trigger the length error.
    testWidgets('shows password length error for short password', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).first, 'a@b.com');
      await tester.enterText(find.byType(TextFormField).last, '123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });

    // A bad email with a valid password must show only the email error, not the password error.
    testWidgets('shows only email error when password is valid', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.enterText(find.byType(TextFormField).first, 'bad-email');
      await tester.enterText(find.byType(TextFormField).last, 'validpassword');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(find.text('Password is required'), findsNothing);
      expect(find.text('Password must be at least 6 characters'), findsNothing);
    });

    // A valid email with a short password must show only the password error.
    testWidgets('shows only password error when email is valid', (tester) async {
      await tester.pumpWidget(buildLoginPage());
      await tester.pump();

      await tester.enterText(
        find.byType(TextFormField).first,
        'valid@example.com',
      );
      await tester.enterText(find.byType(TextFormField).last, '123');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Email is required'), findsNothing);
      expect(find.text('Enter a valid email address'), findsNothing);
      expect(find.text('Password must be at least 6 characters'), findsOneWidget);
    });
  });
}
