import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInitial()) {
    on<LoadRecentScansEvent>(_onLoadRecentScans);
    on<SearchProductEvent>(_onSearchProduct);
  }

  Future<void> _onLoadRecentScans(
    LoadRecentScansEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      emit(const HomeLoaded(recentScans: []));
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
      await Future.delayed(const Duration(seconds: 1));
      emit(const HomeLoaded(recentScans: []));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
