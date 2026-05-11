import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/features/auth/presentation/pages/login_page.dart';
import 'package:food_scan/features/auth/presentation/pages/register_page.dart';
import 'package:food_scan/features/home/presentation/pages/home_page.dart';
import 'package:food_scan/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_scan/features/details/presentation/pages/details_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/';
  static const String scanner = '/scanner';
  static const String details = '/details/:barcode';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    refreshListenable: _GoRouterRefreshStream(
      FirebaseAuth.instance.authStateChanges(),
    ),
    redirect: (BuildContext context, GoRouterState state) {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      final onAuthRoute =
          state.matchedLocation == login ||
          state.matchedLocation == register;

      if (!isLoggedIn && !onAuthRoute) return login;
      if (isLoggedIn && onAuthRoute) return home;
      return null;
    },
    errorPageBuilder: (context, state) {
      return const NoTransitionPage(
        child: Scaffold(body: Center(child: Text('Seite nicht gefunden'))),
      );
    },
    routes: [
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: scanner,
        name: 'scanner',
        builder: (context, state) => const ScannerPage(),
      ),
      GoRoute(
        path: details,
        name: 'details',
        builder: (context, state) {
          final barcode = state.pathParameters['barcode']!;
          return DetailsPage(barcode: barcode);
        },
      ),
    ],
  );
}

class _GoRouterRefreshStream extends ChangeNotifier {
  _GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _sub = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _sub;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
