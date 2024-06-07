part of 'chat_bloc.dart';

class ChatState {
  ActiveDocument? currentDocument;
  Map<ActiveDocument, List<ChatMessage>> visibleConversationsByActiveDocument;
  Map<ActiveDocument, List<ChatMessage>> conversationsByActiveDocument;
  Map<ActiveDocument, List<StickyNote>> stickyNotesByActiveDocument;
  List<StickyNote> visibleNotes;
  List<ChatMessage> visibleMessages;
  bool isLoading;

  ChatState({
    this.currentDocument,
    this.visibleConversationsByActiveDocument = const {},
    this.conversationsByActiveDocument = const {},
    this.stickyNotesByActiveDocument = const {},
    this.visibleNotes = const [],
    this.visibleMessages = const [],
    this.isLoading = false,
  });

  ChatState copyWith({
    ActiveDocument? currentDocument,
    Map<ActiveDocument, List<ChatMessage>>?
        visibleConversationsByActiveDocument,
    Map<ActiveDocument, List<ChatMessage>>? conversationsByActiveDocument,
    Map<ActiveDocument, List<StickyNote>>? stickyNotesByActiveDocument,
    List<StickyNote>? visibleNotes,
    List<ChatMessage>? visibleMessages,
    bool? isLoading,
  }) {
    return ChatState(
      currentDocument: currentDocument ?? this.currentDocument,
      visibleConversationsByActiveDocument:
          visibleConversationsByActiveDocument ??
              this.visibleConversationsByActiveDocument,
      conversationsByActiveDocument:
          conversationsByActiveDocument ?? this.conversationsByActiveDocument,
      stickyNotesByActiveDocument:
          stickyNotesByActiveDocument ?? this.stickyNotesByActiveDocument,
      visibleNotes: visibleNotes ?? this.visibleNotes,
      visibleMessages: visibleMessages ?? this.visibleMessages,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
