import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/data/repositories/scan_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_scan/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

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

class FakeScanRepository implements ScanRepository {
  FakeScanRepository({
    List<ScanPage>? recentPages,
    List<ScanPage>? searchPages,
  })  : recentPages = recentPages ?? [],
        searchPages = searchPages ?? [];

  final List<ScanPage> recentPages;
  final List<ScanPage> searchPages;

  int getScansPageCallCount = 0;
  int searchScansPageCallCount = 0;
  int saveScanCallCount = 0;

  final List<String> searchedQueries = [];

  Future<ScanPage> getScansPage(
    String uid, {
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    getScansPageCallCount++;

    if (recentPages.isEmpty) {
      return page([], hasMore: false);
    }

    return recentPages.removeAt(0);
  }

  Future<ScanPage> searchScansPage(
    String uid, {
    required String queryText,
    int limit = 20,
    DocumentSnapshot<Map<String, dynamic>>? startAfterDocument,
  }) async {
    searchScansPageCallCount++;
    searchedQueries.add(queryText);

    if (searchPages.isEmpty) {
      return page([], hasMore: false);
    }

    return searchPages.removeAt(0);
  }

  Future<void> saveScan(String uid, ScanRecord scan) async {
    saveScanCallCount++;
  }

  Future<List<ScanRecord>> getScans(String uid) async {
    // Delegate to getScansPage to mimic real repository behavior
    final page = await getScansPage(uid, limit: 20);
    return page.scans;
  }
}

HomeBloc createBloc(FakeScanRepository repository) {
  return HomeBloc(
    scanRepository: repository,
    currentUidProvider: () => 'test-user-id',
    authStateChanges: const Stream<User?>.empty(),
  );
}

void main() {
  group('HomeBloc pagination', () {
    test('LoadRecentScansEvent loads first recent scans page', () async {
      final repository = FakeScanRepository(
        recentPages: [
          page(
            [
              scan('111', 'Apple'),
              scan('222', 'Milk'),
            ],
            hasMore: true,
          ),
        ],
      );

      final bloc = createBloc(repository);
      addTearDown(bloc.close);

      bloc.add(const LoadRecentScansEvent());
      await pumpEventQueue();

      expect(repository.getScansPageCallCount, 1);

      final state = bloc.state;
      expect(state, isA<HomeLoaded>());

      final loaded = state as HomeLoaded;
      expect(loaded.isSearchMode, isFalse);
      expect(loaded.recentScans.length, 2);
      expect(loaded.hasMoreRecentScans, isTrue);
      expect(loaded.isLoadingMoreRecentScans, isFalse);
    });

    test('LoadMoreRecentScansEvent appends next recent page', () async {
      final repository = FakeScanRepository(
        recentPages: [
          page(
            [
              scan('111', 'Apple'),
              scan('222', 'Milk'),
            ],
            hasMore: true,
          ),
          page(
            [
              scan('333', 'Bread'),
            ],
            hasMore: false,
          ),
        ],
      );

      final bloc = createBloc(repository);
      addTearDown(bloc.close);

      bloc.add(const LoadRecentScansEvent());
      await pumpEventQueue();

      final emittedStates = <HomeState>[];
      final subscription = bloc.stream.listen(emittedStates.add);

      bloc.add(const LoadMoreRecentScansEvent());
      await pumpEventQueue();

      expect(repository.getScansPageCallCount, 2);
      expect(emittedStates.length, 2);

      expect(
        (emittedStates[0] as HomeLoaded).isLoadingMoreRecentScans,
        isTrue,
      );

      final loaded = emittedStates[1] as HomeLoaded;
      expect(loaded.isLoadingMoreRecentScans, isFalse);
      expect(loaded.hasMoreRecentScans, isFalse);
      expect(loaded.recentScans.map((s) => s.barcode), ['111', '222', '333']);

      await subscription.cancel();
    });

  });
}
