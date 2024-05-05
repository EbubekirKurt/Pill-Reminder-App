import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/views/medicine/view/add_medication_page.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/bloc/nav_bar_bloc.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});
  @override
  Widget build(BuildContext context) {
    final navBloc = context.read<NavBarBloc>();
    return BlocBuilder<NavBarBloc, NavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: navBloc.pages[navBloc.selectIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: green,
            backgroundColor: pureWhite,
            showUnselectedLabels: true,
            currentIndex: navBloc.selectIndex,
            onTap: (value) {
              navBloc.add(ChangeIndexEvent(value));
            },
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  color: green,
                ),
                icon: SvgPicture.asset('assets/icons/home.svg'),
                label: 'Ana Sayfa',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/drugs.svg',
                  color: green,
                ),
                icon: SvgPicture.asset('assets/icons/drugs.svg'),
                label: 'İlaçlarım',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.abc),
                label: '',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/ask.svg',
                  color: green,
                ),
                icon: SvgPicture.asset('assets/icons/ask.svg'),
                label: 'Yardım İste',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  'assets/icons/med.svg',
                  color: green,
                ),
                icon: SvgPicture.asset('assets/icons/med.svg'),
                label: 'İlaç Tara',
              ),
            ],
          ),
          floatingActionButton: Align(
            alignment: const Alignment(0.0, 0.95),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: green,
                    spreadRadius: 1,
                    blurRadius: 30,
                    offset: Offset(0, 4),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton(
                onPressed: () {
                  context.push(view: AddMedicationPage(), isPush: true);
                },
                backgroundColor: green,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
