part of 'chat_gpt_bloc.dart';

@immutable
sealed class ChatGptEvent {}

class SendMessageEvent extends ChatGptEvent {
  final ChatMessage chatMessage;
  SendMessageEvent({required this.chatMessage});
}

class DeleteMessageEvent extends ChatGptEvent {
  final ChatMessage msg;
  DeleteMessageEvent({required this.msg});
}
