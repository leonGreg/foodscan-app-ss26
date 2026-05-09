import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<Product> _history = [];

  HomeBloc() : super(const HomeInitial()) {
    on<LoadRecentScansEvent>(_onLoadRecentScans);
    on<SearchProductEvent>(_onSearchProduct);
    on<AddProductToHistoryEvent>(_onAddProductToHistory);
  }

  Future<void> _onLoadRecentScans(
    LoadRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      // simulate delay
      await Future.delayed(const Duration(milliseconds: 500));
      emit(HomeLoaded(recentScans: List.from(_history)));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  Future<void> _onSearchProduct(
    SearchProductEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      // For now, search just filters local history or returns empty
      final filtered = _history
          .where((product) =>
              product.productName.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(HomeLoaded(recentScans: filtered));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }

  void _onAddProductToHistory(
    AddProductToHistoryEvent event,
    Emitter<HomeState> emit,
  ) {
    // Remove if already exists to move to top
    _history.removeWhere((product) => product.code == event.product.code);
    _history.insert(0, event.product);
    
    // Limit history size to e.g. 20
    if (_history.length > 20) {
      _history.removeLast();
    }

    emit(HomeLoaded(recentScans: List.from(_history)));
  }
}
