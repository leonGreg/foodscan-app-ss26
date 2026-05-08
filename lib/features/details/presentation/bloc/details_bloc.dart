import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(const DetailsInitial()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ResetDetailsEvent>(_onReset);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(const DetailsLoading());
    try {
      // TODO: Fetch product details from API/repository based on barcode
      // For now, simulate with mock data
      await Future.delayed(const Duration(seconds: 1));
      
      final mockProduct = Product(
        code: event.barcode,
        productName: 'Product Name',
        brands: 'Brand',
        imageFrontUrl: null,
        nutritionGrade: 'E',
        ingredientsText: null,
        allergensTags: const [],
        categoriesTags: const [],
        nutriments: null,
      );
      
      emit(DetailsLoaded(product: mockProduct));
    } catch (e) {
      emit(DetailsError(message: e.toString()));
    }
  }

  void _onReset(ResetDetailsEvent event, Emitter<DetailsState> emit) {
    emit(const DetailsInitial());
  }
}
