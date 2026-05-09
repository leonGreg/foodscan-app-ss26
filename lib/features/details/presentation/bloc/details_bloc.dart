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
        productName: 'Example Chocolate Nut Spread',
        brands: 'Ferrero',
        imageFrontUrl: null,
        nutritionGrade: 'E',
        ecoScore: 'D',
        ingredientsText:
            'Sugar, Palm Oil, Hazelnuts (13%), Skimmed Milk Powder (8.7%), Fat-Reduced Cocoa (7.4%), Emulsifier: Lecithins (Soya), Vanillin',
        allergensTags: const ['en:hazelnuts', 'en:milk', 'en:soybeans'],
        categoriesTags: const [
          'en:breakfasts',
          'en:spreads',
          'en:sweet-spreads',
        ],
        additivesTags: const ['en:e322', 'en:e322i'],
        nutriments: const ProductNutriments(
          energyKcal100g: 539,
          fat100g: 30.9,
          saturatedFat100g: 10.6,
          carbohydrates100g: 57.5,
          sugars100g: 56.3,
          proteins100g: 6.3,
          salt100g: 0.107,
        ),
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
