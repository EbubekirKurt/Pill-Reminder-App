import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/data_layer/data_layer.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/auth/bloc/auth_bloc.dart';
import 'package:medicine_reminder_app/views/auth/view/login_page.dart';
import 'package:medicine_reminder_app/views/auth/view/password_change_view.dart';
import 'package:medicine_reminder_app/widgets/custom_elevated_button.dart';
import 'package:medicine_reminder_app/widgets/custom_lodaing_circle.dart';
import 'package:medicine_reminder_app/widgets/otp_text_field.dart';
import 'package:timer_button/timer_button.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceLocator = DataInjection().locator.get<DBServices>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.push(view: ChangePasswordView(), isPush: true);
          context.getMessages(msg: state.msg, color: green,);
        } else if (state is AuthErrorState) {
          context.getMessages(msg: state.msg, color: red);
        }
      },
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return LoadingScreen();
        }
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: Center(
                child: Column(
                  children: [
                    height32,
                    CircleAvatar(
                      radius: 100,
                      child: Image.asset(
                        'assets/images/mail.jpg',
                        width: 250,
                        height: 250,
                      ),
                    ),
                    height32,
                    Container(
                      width: context.getWidth(),
                      height: context.getHeight() * 0.35,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 0.2),
                        color: grayLight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Şifrenizi kurtarmak için e-posta adresinize bir doğrulama kodu gönderildi. Lütfen e-postanızı kontrol edin ve şifre kurtarma işlemini tamamlamak için talimatları izleyin.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'MarkaziText',
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          height20,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFieldOTP(
                                  controller: controller1,
                                  first: true,
                                  last: false),
                              TextFieldOTP(
                                  controller: controller2,
                                  first: false,
                                  last: false),
                              TextFieldOTP(
                                  controller: controller3,
                                  first: false,
                                  last: false),
                              TextFieldOTP(
                                  controller: controller4,
                                  first: false,
                                  last: false),
                              TextFieldOTP(
                                  controller: controller5,
                                  first: false,
                                  last: false),
                              TextFieldOTP(
                                  controller: controller6,
                                  first: false,
                                  last: true),
                            ],
                          ),
                          TimerButton.builder(
                              builder: (context, timeLeft) {
                                return TextButton(
                                  onPressed: () {}, // Ignore this pressed
                                  child: Text(
                                    "Doğrulama kodunu daha sonra tekrar gönderin: ${timeLeft + 1}",
                                    style: TextStyle(color: green,),
                                  ),
                                );
                              },
                              onPressed: () {
                                context.read<AuthBloc>().add(ResendOtpEvent());
                              },
                              timeOutInSeconds: 60),
                        ],
                      ),
                    ),
                    height20,
                    CustomElevatedButton(
                      buttonColor: green,
                      styleColor: white,
                      text: "Devam et",
                      onPressed: () {
                        String otpToken = controller1.text +
                            controller2.text +
                            controller3.text +
                            controller4.text +
                            controller5.text +
                            controller6.text;
                        context.read<AuthBloc>().add(ConfirmOtpEvent(
                            email: serviceLocator.email, otpToken: otpToken));
                      },
                    ),
                    TextButton(
                        onPressed: () {
                          context.push(view: LoginView(), isPush: true);
                        },
                        child: Text(
                          "Giriş Ekranına Dön",
                          style: TextStyle(color: grey, fontFamily: 'MarkaziText',
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
