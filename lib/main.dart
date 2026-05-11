import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'app/app.dart';

void main() {
  // Set the global UserAgent for all queries
  OpenFoodAPIConfiguration.userAgent = UserAgent(name: 'FoodScanApp');

  runApp(const FoodScanApp());
}
