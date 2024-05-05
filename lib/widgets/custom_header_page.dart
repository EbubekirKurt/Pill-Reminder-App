import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/start_page/first_page.dart';

class HeaderHomePage extends StatelessWidget {
  const HeaderHomePage({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(view: FirstView(), isPush: true);
          context.getMessages(
            msg: state.msg,
            color: green,
          );
        } else if (state is AuthErrorState) {
          context.getMessages(
            msg: state.msg,
            color: red,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: green,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -45,
              left: 30,
              child: Container(
                width: 112,
                height: 140,
                decoration: BoxDecoration(
                  color: pureWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      height16,
                      Image.asset(
                        'assets/images/header_logo.jpg',
                        width: 83,
                        height: 80,
                      ),
                      Text(
                        'İlaç Hatırlatma\n\t\t\t\t\t\t\tSistemi',
                        style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 15,
                            color: green,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: 100,
                height: 120,
                child: Text(
                  "Hoş\ngeldin ",
                  style: TextStyle(
                      fontFamily: 'MarkaziText',
                      fontSize: 40,
                      color: pureWhite,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 30,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Text(
                  "ًُ",
                  style: TextStyle(
                      fontSize: 40,
                      color: pureWhite,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 7,
              child: Container(
                width: 26,
                height: 26,
                child: Center(
                  child: IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      icon: Icon(
                        Icons.logout,
                        color: white,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
