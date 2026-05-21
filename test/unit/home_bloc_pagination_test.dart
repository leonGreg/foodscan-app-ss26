import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/data/repositories/scan_repository.dart';

ScanRecord scan(String barcode, String name) {
  final product = Product(
    code: barcode,
    productName: name,
    nutritionGrade: 'a',
  );

  return ScanRecord.fromProduct(product);
}

ScanPage page(
  List<ScanRecord> scans, {
  required bool hasMore,
}) {
  return ScanPage(
    scans: scans,
    lastDocument: null,
    hasMore: hasMore,
  );
}
