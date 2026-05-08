import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:food_scan/features/home/presentation/pages/home_page.dart';
import 'package:food_scan/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_scan/features/details/presentation/pages/details_page.dart';

class AppRouter {
  static const String home = '/';
  static const String scanner = '/scanner';
  static const String details = '/details/:barcode';
  static const String about = '/about';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    errorPageBuilder: (context, state) {
      return const NoTransitionPage(
        child: Scaffold(body: Center(child: Text('Page not found'))), // TODO: replace
      );
    },
    routes: [
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
