import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder_app/views/ai_chat/view/ask_ai.dart';
import 'package:medicine_reminder_app/views/medicine/view/add_medication_page.dart';
import 'package:medicine_reminder_app/views/medicine/view/home_page.dart';
import 'package:medicine_reminder_app/views/medicine/view/medicine_page.dart';
import 'package:medicine_reminder_app/views/qr_barcode/view/scan_code_page.dart';
import 'package:meta/meta.dart';

part 'nav_bar_event.dart';
part 'nav_bar_state.dart';

class NavBarBloc extends Bloc<NavBarEvent, NavBarState> {
  List<Widget> pages = <Widget>[
    HomeView(),
    MedicineView(),
    AddMedicationPage(),
    AskAiPage(),
    ScanView()
  ];

  int selectIndex = 0;
  NavBarBloc() : super(NavBarInitial()) {
    on<NavBarEvent>((event, emit) {});
    on<ChangeIndexEvent>(changeIndex);
  }

  FutureOr<void> changeIndex(
      ChangeIndexEvent event, Emitter<NavBarState> emit) {
    selectIndex = event.index;
    emit(SuccessChangeIndex());
  }
}
