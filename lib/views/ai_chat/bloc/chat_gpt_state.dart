part of 'chat_gpt_bloc.dart';

@immutable
sealed class ChatGptState {}

final class ChatGptInitial extends ChatGptState {}

final class MessageChatState extends ChatGptState {}
