part of 'chat_bloc.dart';

class ChatState {
  ActiveDocument? currentDocument;
  Map<String, List<ChatMessage>> visibleConversationsByActiveDocument;
  Map<String, List<ChatMessage>> conversationsByActiveDocument;
  Map<String, List<StickyNote>> stickyNotesByActiveDocument;
  List<StickyNote> visibleNotes;
  List<ChatMessage> visibleMessages;
  List<String>? messageSuggestions;
  bool isLoading;

  ChatState({
    this.currentDocument,
    this.visibleConversationsByActiveDocument = const {},
    this.conversationsByActiveDocument = const {},
    this.stickyNotesByActiveDocument = const {},
    this.visibleNotes = const [],
    this.visibleMessages = const [],
    this.messageSuggestions = const [],
    this.isLoading = false,
  });

  ChatState copyWith({
    ActiveDocument? currentDocument,
    Map<String, List<ChatMessage>>? visibleConversationsByActiveDocument,
    Map<String, List<ChatMessage>>? conversationsByActiveDocument,
    Map<String, List<StickyNote>>? stickyNotesByActiveDocument,
    List<StickyNote>? visibleNotes,
    List<ChatMessage>? visibleMessages,
    List<String>? messageSuggestions,
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
      messageSuggestions: messageSuggestions ?? this.messageSuggestions,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
