import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'scanner_event.dart';
part 'scanner_state.dart';

class ScannerBloc extends Bloc<ScannerEvent, ScannerState> {
  ScannerBloc() : super(const ScannerInitial()) {
    on<BarcodeDetectedEvent>(_onBarcodeDetected);
  }

  Future<void> _onBarcodeDetected(
    BarcodeDetectedEvent event,
    Emitter<ScannerState> emit,
  ) async {
    try {
      // Emit the detected barcode
      emit(ScannerBarcodeDetected(barcode: event.barcode));
    } catch (e) {
      emit(ScannerError(message: e.toString()));
    }
  }
}

