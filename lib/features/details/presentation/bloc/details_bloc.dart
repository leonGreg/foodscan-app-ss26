import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_scan/core/models/product_model.dart';
import 'package:food_scan/data/repositories/product_repository.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductRepository _productRepository;

  DetailsBloc({ProductRepository? productRepository})
      : _productRepository = productRepository ?? ProductRepository(),
        super(const DetailsInitial()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ResetDetailsEvent>(_onReset);
  }

  Future<void> _onLoadProductDetails(
    LoadProductDetailsEvent event,
    Emitter<DetailsState> emit,
  ) async {
    emit(const DetailsLoading());
    try {
      final product = await _productRepository.getProduct(event.barcode);
      
      if (product != null) {
        emit(DetailsLoaded(product: product));
      } else {
        emit(const DetailsError(message: 'Product not found'));
      }
    } catch (e) {
      emit(DetailsError(message: 'Error fetching product: ${e.toString()}'));
    }
  }

  void _onReset(ResetDetailsEvent event, Emitter<DetailsState> emit) {
    emit(const DetailsInitial());
  }
}
