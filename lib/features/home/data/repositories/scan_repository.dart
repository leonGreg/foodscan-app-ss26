import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';

class ScanPage {
  final List<ScanRecord> scans;
  final DocumentSnapshot<Map<String, dynamic>>? lastDocument;
  final bool hasMore;

  const ScanPage({
    required this.scans,
    required this.lastDocument,
    required this.hasMore,
  });
}

class ScanRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<ScanPage> getScansPage(
    String uid, {
    int limit = 8,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(uid)
        .collection('scans')
        .orderBy('scannedAt', descending: true)
        .limit(limit);

    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }

    final snapshot = await query.get();

    final scans = snapshot.docs.map(ScanRecord.fromFirestore).toList();

    return ScanPage(
      scans: scans,
      lastDocument: snapshot.docs.isEmpty ? startAfterDocument : snapshot.docs.last,
      hasMore: snapshot.docs.length == limit,
    );
  }

  Future<List<ScanRecord>> getScans(String uid) async {
    final page = await getScansPage(uid, limit: 8);
    return page.scans;
    // final snapshot = await _firestore
    //     .collection('users')
    //     .doc(uid)
    //     .collection('scans')
    //     .orderBy('scannedAt', descending: true)
    //     .limit(20)
    //     .get();
    // return snapshot.docs.map(ScanRecord.fromFirestore).toList();
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
