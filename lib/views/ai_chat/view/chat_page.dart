import 'dart:ui';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medicine_reminder_app/utils/colors.dart';
import 'package:medicine_reminder_app/views/ai_chat/bloc/chat_gpt_bloc.dart';
import 'package:medicine_reminder_app/widgets/appBar_arrow_back.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ChatGptBloc>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [green, greenLight, white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: const [AppBarArrowBack()],
            automaticallyImplyLeading: false),
        body: BlocBuilder<ChatGptBloc, ChatGptState>(
          builder: (context, state) {
            return DashChat(
              messageOptions: MessageOptions(
                showCurrentUserAvatar: true,
                avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                  return Image.asset(
                    p0.profileImage ?? 'assets/images/avatar.PNG',
                    height: 50,
                    width: 50,
                  );
                },
                currentUserContainerColor: const Color(0xffF8F8F6),
                currentUserTextColor: Colors.black54,
                borderRadius: 29,
                containerColor: const Color(0xffF8F8F6),
                textColor: Colors.black54,
                showTime: true,
                onLongPressMessage: (p0) {
                  bloc.add(DeleteMessageEvent(msg: p0));
                },
              ),
              typingUsers: bloc.typingList,
              currentUser: bloc.user,
              inputOptions: InputOptions(
                inputDecoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: green),
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                  fillColor: Colors.white,
                  hintTextDirection: TextDirection.rtl,
                  hintText: "Buraya yaz.",
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: greenLight),
                      borderRadius: BorderRadius.all(Radius.circular(60))),
                ),
              ),
              onSend: (ChatMessage chatMessage) async {
                bloc.add(SendMessageEvent(chatMessage: chatMessage));
              },
              messages: bloc.messages,
            );
          },
        ),
      ),
    );
  }
}
