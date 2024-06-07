part of 'chat_bloc.dart';

class ChatState {
  ActiveDocument? currentDocument;

  ChatState({
    this.currentDocument,
  });

  ChatState copyWith({
    ActiveDocument? currentDocument,
  }) {
    return ChatState(
      currentDocument: currentDocument ?? this.currentDocument,
    );
  }
}
