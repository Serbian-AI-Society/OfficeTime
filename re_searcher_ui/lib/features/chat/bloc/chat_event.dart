part of 'chat_bloc.dart';

sealed class ChatEvent {}

class SetActiveDocumentEvent extends ChatEvent {
  final ActiveDocument document;
  SetActiveDocumentEvent({
    required this.document,
  });
}

class InitChatBlocEvent extends ChatEvent {}

class DeleteNoteEvent extends ChatEvent {
  final StickyNote note;
  DeleteNoteEvent({
    required this.note,
  });
}

class SendMessageEvet extends ChatEvent {
  String message;
  SendMessageEvet({
    required this.message,
  });
}
