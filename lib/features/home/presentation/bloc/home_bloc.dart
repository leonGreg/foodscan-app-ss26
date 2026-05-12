import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/features/home/data/models/scan_record.dart';
import 'package:food_scan/features/home/data/repositories/scan_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ScanRepository _scanRepository;
  List<ScanRecord> _allScans = [];

  HomeBloc({required ScanRepository scanRepository})
      : _scanRepository = scanRepository,
        super(const HomeInitial()) {
    on<LoadRecentScansEvent>(_onLoadRecentScans);
    on<SearchProductEvent>(_onSearchProduct);
    on<AddProductToHistoryEvent>(_onAddProductToHistory);
  }

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> _onLoadRecentScans(
    LoadRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) {
      emit(const HomeLoaded(recentScans: []));
      return;
    }
    emit(const HomeLoading());
    try {
      _allScans = await _scanRepository.getScans(uid);
      emit(HomeLoaded(recentScans: _allScans));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onSearchProduct(SearchProductEvent event, Emitter<HomeState> emit) {
    if (event.query.isEmpty) {
      emit(HomeLoaded(recentScans: _allScans));
      return;
    }
    final filtered = _allScans
        .where(
          (scan) => scan.productName.toLowerCase().contains(
            event.query.toLowerCase(),
          ),
        )
        .toList();
    emit(HomeLoaded(recentScans: filtered));
  }

  Future<void> _onAddProductToHistory(
    AddProductToHistoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    final uid = _uid;
    if (uid == null) return;

    final scan = ScanRecord.fromProduct(event.product);
    try {
      await _scanRepository.saveScan(uid, scan);
      _allScans = [
        scan,
        ..._allScans.where((s) => s.barcode != scan.barcode),
      ];
      if (_allScans.length > 20) _allScans = _allScans.sublist(0, 20);
      emit(HomeLoaded(recentScans: _allScans));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
