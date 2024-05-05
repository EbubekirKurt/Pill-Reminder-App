import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:medicine_reminder_app/service/gpt_api.dart';
import 'package:meta/meta.dart';

part 'chat_gpt_event.dart';
part 'chat_gpt_state.dart';

class ChatGptBloc extends Bloc<ChatGptEvent, ChatGptState> {
  ChatUser user = ChatUser(
      id: "1",
      );
  ChatUser bot = ChatUser(
      id: "2",
      profileImage:
          "assets/images/logo_2.png");
  List<ChatMessage> messages = [];
  List<ChatUser> typingList = [];

  ChatGptBloc() : super(ChatGptInitial()) {
    on<ChatGptEvent>((event, emit) {});
    on<DeleteMessageEvent>((event, emit) {
      messages.remove(event.msg);
      emit(MessageChatState());
    });
    on<SendMessageEvent>((event, emit) async {
      if (event.chatMessage.text.trim().isNotEmpty) {
        messages.insert(0, event.chatMessage);
        typingList.add(bot);
        emit(MessageChatState());

        final answer = await ChatGPT().getChatAnswer(event.chatMessage.text);
        final newMessage = ChatMessage(
          text: answer,
          user: bot,
          createdAt: DateTime.now(),
        );
        messages.insert(0, newMessage);
        typingList.remove(bot);
        emit(MessageChatState());
      }
    });
  }
}
