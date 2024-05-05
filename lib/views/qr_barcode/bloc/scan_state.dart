part of 'scan_bloc.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}

class ScanSuccess extends ScanState {
  final String qrString;

  ScanSuccess(this.qrString);
}

class ScanFailure extends ScanState {}

class ScanCanceled extends ScanState {}
