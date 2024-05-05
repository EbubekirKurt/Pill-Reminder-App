part of 'medicine_bloc.dart';

@immutable
sealed class MedicineEvent {}

class MedicineLoadEvent extends MedicineEvent {}

class MedicineAdded extends MedicineEvent {
  final MedicineModel medicine;

  MedicineAdded({required this.medicine});
}

class MedicineDeleted extends MedicineEvent {
  final MedicineModel medicine;

  MedicineDeleted({required this.medicine});
}

class MedicineUpdated extends MedicineEvent {
  final MedicineModel medicine;
  final String id;
  MedicineUpdated({required this.medicine, required this.id});
}
