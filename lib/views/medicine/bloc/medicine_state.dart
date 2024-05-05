part of 'medicine_bloc.dart';

@immutable
sealed class MedicineState {}

final class MedicineInitial extends MedicineState {}

final class MedicineLoadingState extends MedicineState {}

final class MedicineLoadedState extends MedicineState {
  final List<MedicineModel> list;
  MedicineLoadedState({required this.list});
}

final class MedicineSuccessState extends MedicineState {
  final String msg;
  MedicineSuccessState({required this.msg});
}

final class MedicineErrorState extends MedicineState {
  final String msg;
  MedicineErrorState({required this.msg});
}
