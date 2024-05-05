import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/views/auth/view/siginup_page.dart';
import 'package:medicine_reminder_app/views/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      bottomSheet: Container(
        height: 300,
        width: double.infinity,
        decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              height20,
              CustomElevatedButton(
                text: "Giriş Yap",
                buttonColor: green,
                styleColor: white,
                onPressed: () {
                  context.push(view: LoginView(), isPush: false);
                },
              ),
              height20,
              CustomElevatedButton(
                text: "Ziyaretçi olarak oturum aç",
                buttonColor: white,
                borderColor: green,
                styleColor: black,
                onPressed: () {
                  context.push(view: BottomNav(), isPush: false);
                },
              ),
              height20,
              CustomElevatedButton(
                text: "Yeni Kayıt",
                buttonColor: green,
                styleColor: white,
                onPressed: () {
                  // ** here is logic ** \\
                  context.push(view: SignUpView(), isPush: false);
                },
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [green, green, greenLight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo_2.png',
                width: 175,
                height: 175,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/hand_pell.svg'),
                  width4,
                  Text(
                    'Pill Reminder App',
                    style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 35,
                        height: 0.1,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              height100
            ],
          ),
        ),
      ),
    );
  }
}
