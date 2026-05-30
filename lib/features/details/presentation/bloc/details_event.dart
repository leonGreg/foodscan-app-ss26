part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProductDetailsEvent extends DetailsEvent {
  final String barcode;
  final String languageCode;

  const LoadProductDetailsEvent(this.barcode, this.languageCode);

  @override
  List<Object?> get props => [barcode, languageCode];
}

class ResetDetailsEvent extends DetailsEvent {
  const ResetDetailsEvent();
}
