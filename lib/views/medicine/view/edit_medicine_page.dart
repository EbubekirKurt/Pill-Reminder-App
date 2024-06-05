import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/model/medicine_model.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/widgets/appBar_arrow_back.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_label.dart';
import 'package:medicine_reminder_app/widgets/custom_notification.dart';
import 'package:medicine_reminder_app/widgets/custom_drop_menu.dart';

class EditMedicineView extends StatelessWidget {
  const EditMedicineView({super.key, required this.medicine});
  final MedicineModel medicine;
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBServices>();
    return BlocProvider(
      create: (context) => MedicineBloc(),
      child: BlocConsumer<MedicineBloc, MedicineState>(
        listener: (context, state) {
          if (state is MedicineSuccessState) {
            context.push(view: const BottomNav(), isPush: false);
            context.getMessages(msg: state.msg, color: green);
          } else if (state is MedicineErrorState) {
            context.getMessages(msg: state.msg, color: red);
          }
        },
        builder: (context, state) {
          TextEditingController pellName =
              TextEditingController(text: medicine.name);
          final bloc = BlocProvider.of<MedicineBloc>(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
                actions: const [AppBarArrowBack()],
                automaticallyImplyLeading: false),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  height40,
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "İlaç Düzenle",
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )),
                  height40,
                  const CustomLabel(label: 'İlaç Adı'),
                  height10,
                  SizedBox(
                      height: 48,
                      width: 319,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: white),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 48,
                            width: 319,
                            child: TextField(
                              controller: pellName,
                              textDirection: TextDirection.rtl,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, top: 12, bottom: 18),
                                  child: SvgPicture.asset(
                                      "assets/icons/drugs.svg"),
                                ),
                                hintTextDirection: TextDirection.rtl,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                fillColor: white,
                                alignLabelWithHint: true,
                              ),
                            ),
                          ),
                        ),
                      )),
                  height48,
                  const CustomLabel(
                    label: "Günde kaç hap ve ilacın etkisi ne kadar sürüyor?",
                  ),
                  height10,
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      DropMenu(),
                    ],
                  ),
                  height56,
                  const CustomLabel(label: "Bildirimler"),
                  height10,
                  const Notifications(),
                  height80,
                  CustomElevatedButton(
                    text: "Kaydet",
                    buttonColor: green,
                    styleColor: white,
                    onPressed: () async {
                      final user_id = await locator.getCurrentUserId();
                      bloc.add(MedicineUpdated(
                          medicine: MedicineModel(
                              name: pellName.text,
                              count: locator.pellCount,
                              period: locator.pellPireod,
                              time: locator.time.toString(),
                              userId: user_id),
                          id: medicine.id!));
                    },
                  ),
                  height10,
                  CustomElevatedButton(
                    text: "Sil",
                    buttonColor: pureWhite,
                    styleColor: black,
                    borderColor: green,
                    onPressed: () async {
                      bloc.add(MedicineDeleted(medicine: medicine));
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
