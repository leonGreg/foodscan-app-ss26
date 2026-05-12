import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';

class ScanRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<ScanRecord>> getScans(String uid) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('scans')
        .orderBy('scannedAt', descending: true)
        .limit(20)
        .get();
    return snapshot.docs.map(ScanRecord.fromFirestore).toList();
  }

  Future<void> saveScan(String uid, ScanRecord scan) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('scans')
        .doc(scan.barcode)
        .set(scan.toFirestore());
  }
}
