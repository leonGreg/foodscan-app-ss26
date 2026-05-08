part of 'scanner_bloc.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object?> get props => [];
}

class ScannerInitial extends ScannerState {
  const ScannerInitial();
}

class ScannerBarcodeDetected extends ScannerState {
  final String barcode;

  const ScannerBarcodeDetected({required this.barcode});

  @override
  List<Object?> get props => [barcode];
}

class ScannerError extends ScannerState {
  final String message;

  const ScannerError({required this.message});

  @override
  List<Object?> get props => [message];
}

