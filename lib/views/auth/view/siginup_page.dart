import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: Builder(builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController emailController = TextEditingController();
        TextEditingController passwordController = TextEditingController();
        return Scaffold(
          body: SingleChildScrollView(
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccessState) {
                  context.getMessagesBar(msg: state.msg, color: green);
                  context.push(view: LoginView(), isPush: false);
                } else if (state is AuthErrorState) {
                  context.getMessagesBar(msg: state.msg, color: red);
                }
              },
              builder: (context, state) {
                return Column(
                  children: [
                    Container(
                      width: context.getWidth(),
                      height: context.getHeight() / 2.2,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [green, green, greenLight],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ),
                      ),
                      child:  Center(
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
                                  'Yardım',
                                  style: TextStyle(
                                      fontFamily: 'Cairo',
                                      fontSize: 35,
                                      height: 0.1,
                                      color: white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    height16,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Kullanıcı Adı",
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
                            controller: nameController,
                          ),
                          height26,
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "E-posta",
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
                            controller: emailController,
                          ),
                          height26,
                          const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Şifre",
                              style: TextStyle(
                                fontFamily: 'MarkaziText',
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          height8,
                          TextAuth(
                            isSecure: true,
                            controller: passwordController,
                          ),
                          height32,
                          SizedBox(
                            width: context.getWidth() / 1.2,
                            child: CustomElevatedButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(SignUpEvent(
                                      email: emailController.text,
                                      name: nameController.text,
                                      password: passwordController.text));
                                },
                                buttonColor: green,
                                text: "Yeni Kayıt",
                                styleColor: white),
                          ),
                          TextButton(
                            onPressed: () {
                              context.push(view: LoginView(), isPush: false);
                            },
                            child: Text(
                              "Zaten hesabın var mı?",
                              style: TextStyle(
                                fontFamily: 'MarkaziText',
                                color: green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
