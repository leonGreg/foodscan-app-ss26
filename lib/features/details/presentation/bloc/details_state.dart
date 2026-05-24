part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object?> get props => [];
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsLoaded extends DetailsState {
  final Product product;

  const DetailsLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

enum DetailsErrorType { productNotFound, networkError }

class DetailsError extends DetailsState {
  final DetailsErrorType type;

  const DetailsError({required this.type});

  @override
  List<Object?> get props => [type];
}
