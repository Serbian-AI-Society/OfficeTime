part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SetActiveDocumentEvent extends ChatEvent {
  final ActiveDocument document;
  SetActiveDocumentEvent({
    required this.document,
  });
}

class InitChatBlocEvent extends ChatEvent {}
