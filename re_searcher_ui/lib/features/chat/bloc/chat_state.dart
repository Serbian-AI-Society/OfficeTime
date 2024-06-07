part of 'chat_bloc.dart';

class ChatState {
  ActiveDocument? currentDocument;
  Map<ActiveDocument, List<ChatMessage>> conversationsByActiveDocument;
  Map<ActiveDocument, List<StickyNote>> stickyNotesByActiveDocument;
  List<StickyNote> visibleNotes;
  List<ChatMessage> visibleMessages;

  ChatState({
    this.currentDocument,
    this.conversationsByActiveDocument = const {},
    this.stickyNotesByActiveDocument = const {},
    this.visibleNotes = const [],
    this.visibleMessages = const [],
  });

  ChatState copyWith({
    ActiveDocument? currentDocument,
    Map<ActiveDocument, List<ChatMessage>>? conversationsByActiveDocument,
    Map<ActiveDocument, List<StickyNote>>? stickyNotesByActiveDocument,
    List<StickyNote>? visibleNotes,
    List<ChatMessage>? visibleMessages,
  }) {
    return ChatState(
      currentDocument: currentDocument ?? this.currentDocument,
      conversationsByActiveDocument:
          conversationsByActiveDocument ?? this.conversationsByActiveDocument,
      stickyNotesByActiveDocument:
          stickyNotesByActiveDocument ?? this.stickyNotesByActiveDocument,
      visibleNotes: visibleNotes ?? this.visibleNotes,
      visibleMessages: visibleMessages ?? this.visibleMessages,
    );
  }
}
