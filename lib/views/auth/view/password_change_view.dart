import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_text_field.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({super.key});
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(view: const LoginView(), isPush: true);
          context.getMessagesBar(msg: state.msg, color: green);
        } else if (state is AuthErrorState) {
          context.getMessages(msg: state.msg, color: red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: green,
            leading: IconButton(
                onPressed: () {
                  context.push(view: const LoginView(), isPush: false);
                },
                icon: Icon(Icons.arrow_back, color: pureWhite)),
            title: Text(
              "Geri Dön",
              style: TextStyle(color: pureWhite, fontFamily: 'MarkaziText',
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Yeni Şifre",
                    style: TextStyle(
                      fontFamily: 'MarkaziText',
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                height10,
                TextAuth(
                  controller: newPasswordController,
                  hintText: "Şifre",
                ),
                height20,
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Şifreyi Onayla",
                    style: TextStyle(
                      fontFamily: 'MarkaziText',
                      color: black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                height10,
                TextAuth(
                  controller: confirmPasswordController,
                  hintText: "Şifreyi Onayla",
                ),
                height20,
                CustomElevatedButton(
                  buttonColor: green,
                  styleColor: white,
                  text: "Devamke",
                  onPressed: () {
                    context.read<AuthBloc>().add(ChangePasswordEvent(
                        password: newPasswordController.text,
                        confirmPassword: confirmPasswordController.text));
                  },
                ),
                TextButton(
                    onPressed: () {
                      context.push(view: const LoginView(), isPush: true);
                    },
                    child: Text(
                      "Giriş Ekranına Dön",
                      style: TextStyle(color: grey, fontFamily: 'MarkaziText',
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
