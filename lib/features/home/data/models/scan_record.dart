import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';

class ScanRecord extends Equatable {
  const ScanRecord({
    required this.barcode,
    required this.productName,
    required this.scannedAt,
    this.brands,
    this.imageFrontUrl,
    this.nutritionGrade,
  });

  final String barcode;
  final String productName;
  final String? brands;
  final String? imageFrontUrl;
  final String? nutritionGrade;
  final DateTime scannedAt;

  factory ScanRecord.fromProduct(Product product) => ScanRecord(
    barcode: product.code,
    productName: product.productName,
    brands: product.brands,
    imageFrontUrl: product.imageFrontUrl,
    nutritionGrade: product.nutritionGrade,
    scannedAt: DateTime.now(),
  );

  factory ScanRecord.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ScanRecord(
      barcode: doc.id,
      productName: data['productName'] as String? ?? '',
      brands: data['brands'] as String?,
      imageFrontUrl: data['imageFrontUrl'] as String?,
      nutritionGrade: data['nutritionGrade'] as String?,
      scannedAt: (data['scannedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'productName': productName,
    'brands': brands,
    'imageFrontUrl': imageFrontUrl,
    'nutritionGrade': nutritionGrade,
    'scannedAt': Timestamp.fromDate(scannedAt),
  };

  @override
  List<Object?> get props => [barcode, productName, scannedAt];
}
