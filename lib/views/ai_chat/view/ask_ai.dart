import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:medicine_reminder_app/extensions/screen_handler.dart';
import 'package:medicine_reminder_app/service/supabase_services.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/utils/spacing.dart';
import 'package:medicine_reminder_app/views/ai_chat/view/chat_page.dart';

class AskAiPage extends StatelessWidget {
  const AskAiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<DBServices>();

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [green, green, greenLight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/images/circlerline.png"),
                Positioned(
                    top: 0,
                    right: 30,
                    child: Container(
                        width: 105,
                        height: 50,
                        decoration: BoxDecoration(
                            color: pureWhite,
                            borderRadius: BorderRadius.circular(60)),
                        child:  Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                locator.nameUser,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              width4,
                            ],
                          ),
                        ))),
                Container(
                  height: 220,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/logo_2.png"),
                      Positioned(
                        bottom: 0,
                        left: 40,
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/hand_pell.svg"),
                            width4,
                            Text(
                              "Yardım",
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: pureWhite,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            height16,
            Text(
              "Yardım ettim.",
              style: TextStyle(
                  fontFamily: 'MarkaziText',
                  color: pureWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            Text(
              "Size nasıl yardım edebilirim?",
              style: TextStyle(
                  fontFamily: 'MarkaziText',
                  color: pureWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
            height56,
            ElevatedButton(
                onPressed: () {
                  context.push(view: const ChatPage(), isPush: true);
                },
                child: SvgPicture.asset("assets/icons/chat.svg")),
            height10,
            Text(
              "Konuşmak için tıklayın.",
              style: TextStyle(
                  color: pureWhite, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
