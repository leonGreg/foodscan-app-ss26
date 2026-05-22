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
    int limit = 20,
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
      lastDocument: snapshot.docs.isEmpty
          ? startAfterDocument
          : snapshot.docs.last,
      hasMore: snapshot.docs.length == limit,
    );
  }

  Future<List<ScanRecord>> getScans(String uid) async {
    final page = await getScansPage(uid, limit: 20);
    return page.scans;
  }

  Future<void> saveScan(String uid, ScanRecord scan) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('scans')
        .doc(scan.barcode)
        .set(scan.toFirestore());
  }

  Future<void> deleteScan(String uid, String barcode) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('scans')
        .doc(barcode)
        .delete();
  }

  Future<ScanPage> searchScansPage(
    String uid, {
    required String queryText,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    final normalizedQuery = queryText.toLowerCase().trim();
    final isBarcodeQuery = RegExp(r'^\d+$').hasMatch(normalizedQuery);

    Query<Map<String, dynamic>> query = _firestore
        .collection('users')
        .doc(uid)
        .collection('scans');

    if (isBarcodeQuery) {
      query = query
          .orderBy(FieldPath.documentId)
          .startAt([normalizedQuery])
          .endAt(['$normalizedQuery\uf8ff']);
    } else {
      query = query
          .orderBy('productNameLower')
          .startAt([normalizedQuery])
          .endAt(['$normalizedQuery\uf8ff']);
    }

    if (startAfterDocument != null) {
      query = query.startAfterDocument(startAfterDocument);
    }

    final snapshot = await query.limit(limit + 1).get();

    final docs = snapshot.docs;
    final hasMore = docs.length > limit;
    final visibleDocs = hasMore ? docs.take(limit).toList() : docs;

    final scans = visibleDocs.map(ScanRecord.fromFirestore).toList();

    return ScanPage(
      scans: scans,
      lastDocument: visibleDocs.isEmpty ? startAfterDocument : visibleDocs.last,
      hasMore: hasMore,
    );
  }
}
