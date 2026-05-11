part of 'scanner_bloc.dart';

abstract class ScannerEvent extends Equatable {
  const ScannerEvent();

  @override
  List<Object?> get props => [];
}

class BarcodeDetectedEvent extends ScannerEvent {
  final String barcode;

  const BarcodeDetectedEvent(this.barcode);

  @override
  List<Object?> get props => [barcode];
}

class ScannerResetEvent extends ScannerEvent {
  const ScannerResetEvent();

  @override
  List<Object?> get props => [];
}
