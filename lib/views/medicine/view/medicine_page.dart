import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/widgets/custom_container_medican.dart';
import 'package:medicine_reminder_app/widgets/custom_shimmer_effact.dart';

class MedicineView extends StatelessWidget {
  const MedicineView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineBloc()..add(MedicineLoadEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                height20,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "İlaçlarım",
                    style: TextStyle(
                        fontSize: 40,
                        color: black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                height10,
                BlocConsumer<MedicineBloc, MedicineState>(
                    listener: (context, state) {
                  if (state is MedicineErrorState) {
                    context.getMessages(msg: state.msg, color: red);
                  }
                }, builder: (context, state) {
                  if (state is MedicineLoadingState) {
                    return shimmerEffect();
                  }
                  if (state is MedicineLoadedState) {
                    if (state.list.isNotEmpty) {
                      return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: state.list.length,
                            itemBuilder: (context, index) {
                              return ContainerMedication(
                                medicine: state.list[index],
                                isShowState: false,
                                isEditState: true,
                              );
                            }),
                      );
                    }
                  }
                  return SizedBox(
                    height: context.getHeight() * 0.5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/nodrugs.jpeg"),
                        const Text(
                          "İlaç Ekle",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Container(
                            height: 50,
                            width: 50,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/arrowdown.png",
                                  fit: BoxFit.contain,
                                ),
                              ],
                            )),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
