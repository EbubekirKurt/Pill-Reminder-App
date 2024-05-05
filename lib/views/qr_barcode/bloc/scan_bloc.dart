import 'package:bloc/bloc.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:meta/meta.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  ScanBloc() : super(ScanInitial()) {
    on<ScanQR>((event, emit) async {
      try {
        String qrResult = await FlutterBarcodeScanner.scanBarcode(
            '#2A99CF', 'İPTAL', true, ScanMode.BARCODE);
        if (qrResult == '-1') {
          emit(ScanCanceled());
        } else {
          emit(ScanSuccess(qrResult));
        }
      } catch (e) {
        emit(ScanFailure());
      }
    });
  }
}
