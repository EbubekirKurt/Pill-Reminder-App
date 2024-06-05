import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/medicine/bloc/medicine_bloc.dart';
import 'package:medicine_reminder_app/widgets/custom_container_medican.dart';
import 'package:medicine_reminder_app/widgets/custom_header_page.dart';
import 'package:medicine_reminder_app/widgets/custom_shimmer_effact.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MedicineBloc()..add(MedicineLoadEvent()),
      child: Builder(builder: (context) {
        final locator = GetIt.I.get<DBServices>();
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size(context.getWidth(), context.getHeight() / 5.8),
            child: HeaderHomePage(
              name: locator.nameUser,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: [
                height20,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "İLAÇLARIM",
                    style: TextStyle(
                        fontSize: 30,
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
                  },
                  builder: (context, state) {
                    if (state is MedicineLoadingState) {
                      return shimmerEffect();
                    }
                    if (state is MedicineLoadedState) {
                      if (state.list.isNotEmpty) {
                        return Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                return ContainerMedication(
                                  medicine: state.list[index],
                                  isShowState: true,
                                );
                              }),
                        );
                      }
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        height56,
                        Image.asset("assets/images/nodrugs.jpeg"),
                        Text("İlaç eklenmedi."),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
