part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductDetailsEvent extends DetailsEvent {
  final String barcode;

  const LoadProductDetailsEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class ResetDetailsEvent extends DetailsEvent {
  const ResetDetailsEvent();
}
