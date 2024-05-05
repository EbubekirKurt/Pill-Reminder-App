import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:meta/meta.dart';

part 'medicine_event.dart';
part 'medicine_state.dart';

class MedicineBloc extends Bloc<MedicineEvent, MedicineState> {
  final locator = GetIt.I.get<DBServices>();
  List<MedicineModel> listOfMedicine = [];

  MedicineBloc() : super(MedicineInitial()) {
    on<MedicineEvent>((event, emit) {});
    on<MedicineLoadEvent>(loadMedicineData);
    on<MedicineAdded>(addMedicine);
    on<MedicineUpdated>(updateMedicine);
    on<MedicineDeleted>(deleteMedicine);
  }

  FutureOr<void> loadMedicineData(
      MedicineLoadEvent event, Emitter<MedicineState> emit) async {
    emit(MedicineLoadingState());
    try {
      listOfMedicine = await locator.getAllMedicine();
      emit(MedicineLoadedState(list: listOfMedicine));
    } catch (e) {
      emit(MedicineErrorState(
          msg: "Veritabanından veri yüklenirken bir hata oluştu"));
    }
  }

  FutureOr<void> addMedicine(
      MedicineAdded event, Emitter<MedicineState> emit) async {
    if (event.medicine.name!.trim().isNotEmpty) {
      try {
        await locator.insertMediationData(event.medicine);
        emit(MedicineLoadedState(list: listOfMedicine));
        emit(MedicineSuccessState(msg: "İlaç başarıyla eklendi."));
      } catch (e) {
        emit(MedicineErrorState(msg: "İlaç eklenirken bir hata oluştu"));
      }
    } else {
      emit(MedicineErrorState(msg: "Lütfen gerekli tüm alanları doldurunux."));
    }
  }

  FutureOr<void> updateMedicine(
      MedicineUpdated event, Emitter<MedicineState> emit) async {
    if (event.medicine.name!.trim().isNotEmpty) {
      try {
        await locator.upDateMediationData(event.medicine, event.id);
        emit(MedicineLoadedState(list: listOfMedicine));
        emit(MedicineSuccessState(msg: "İlaç başarıyla güncellendi"));
      } catch (e) {
        emit(MedicineErrorState(msg: "İlaç güncellenirken bir hata oluştu"));
      }
    } else {
      emit(MedicineErrorState(msg: "Lütfen tüm gerekli alanları doldurunuz."));
    }
  }

  FutureOr<void> deleteMedicine(
      MedicineDeleted event, Emitter<MedicineState> emit) async {
    try {
      await locator.deleteMediationData(event.medicine.id!);
      emit(MedicineLoadedState(list: listOfMedicine));
      emit(MedicineSuccessState(msg: "İlaç başarıyla silindi"));
    } catch (e) {
      emit(MedicineErrorState(msg: "İlaç silinirken bir hata oluştu"));
    }
  }
}
