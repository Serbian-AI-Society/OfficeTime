import 'package:bloc/bloc.dart';
import 'package:re_searcher_ui/core/domain/chat_repository.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/model/conversation.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';
import 'package:re_searcher_ui/core/model/user_message_body.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository = IC.getIt();

  ChatBloc() : super(ChatState()) {
    on<SetActiveDocumentEvent>((event, emit) {
      var visibleConversationsByActiveDocument =
          state.visibleConversationsByActiveDocument;

      var stickyNotesByActiveDocument = state.stickyNotesByActiveDocument;

      var visibleMessages =
          visibleConversationsByActiveDocument[event.document.filename] ?? [];
      var visibleNotes =
          stickyNotesByActiveDocument[event.document.filename] ?? [];
      emit(state.copyWith(
          currentDocument: event.document,
          visibleMessages: visibleMessages,
          visibleNotes: visibleNotes));
    });

    on<SendMessageEvet>((event, emit) async {
      var userMessage = ChatMessage(role: "user", content: event.message);
      var visibleMessages = List<ChatMessage>.from(state.visibleMessages);
      var currentConversation = List<ChatMessage>.from(
          state.conversationsByActiveDocument[state.currentDocument] ?? []);

      visibleMessages.add(userMessage);
      currentConversation.add(userMessage);

      emit(state.copyWith(visibleMessages: visibleMessages, isLoading: true));
      try {
        final response = await chatRepository.getAiResponse(UserMessageBody(
            activeDocument: state.currentDocument,
            conversation: currentConversation));

        currentConversation = response.conversation ?? [];
        visibleMessages.add(currentConversation.last);

        var visibleConversationsByActiveDocument =
            Map<String, List<ChatMessage>>.from(
                state.visibleConversationsByActiveDocument);
        var conversationsByActiveDocument = Map<String, List<ChatMessage>>.from(
            state.visibleConversationsByActiveDocument);

        visibleConversationsByActiveDocument[
            state.currentDocument?.filename ?? ""] = visibleMessages;
        conversationsByActiveDocument[state.currentDocument?.filename ?? ""] =
            visibleMessages;

        if (response.newStickyNote != null) {
          var stickyNotesByActiveDocument = Map<String, List<StickyNote>>.from(
              state.stickyNotesByActiveDocument);

          var visibleNotes = List<StickyNote>.from(state.visibleNotes);
          visibleNotes.add(response.newStickyNote!);

          stickyNotesByActiveDocument[state.currentDocument?.filename ?? ""] =
              visibleNotes;

          emit(state.copyWith(
              stickyNotesByActiveDocument: stickyNotesByActiveDocument,
              visibleNotes: visibleNotes));
        }

        emit(state.copyWith(
            conversationsByActiveDocument: conversationsByActiveDocument,
            visibleConversationsByActiveDocument:
                visibleConversationsByActiveDocument,
            visibleMessages: visibleMessages));
      } on Exception catch (error) {
        visibleMessages
            .add(ChatMessage(role: "ERROR", content: error.toString()));
        emit(state.copyWith(visibleMessages: visibleMessages));
      } finally {
        emit(state.copyWith(isLoading: false));
      }
    });

    on<DeleteNoteEvent>((event, emit) {
      final currentDocument = state.currentDocument;
      final stickyNotesByActiveDocument = state.stickyNotesByActiveDocument;
      final visibleNotes = state.visibleNotes;

      visibleNotes.remove(event.note);
      if (currentDocument != null) {
        stickyNotesByActiveDocument[currentDocument.filename ?? ""] =
            visibleNotes;
      }

      emit(
        state.copyWith(
            visibleNotes: visibleNotes,
            stickyNotesByActiveDocument: stickyNotesByActiveDocument),
      );
    });

    on<InitChatBlocEvent>(
      (event, emit) {
        if (state.currentDocument == null) {
          emit(state.copyWith(
              currentDocument: ActiveDocument(
                  name: "Don Kihot",
                  filename: "don_kihot.pdf",
                  description: "Čuvena novela Servantesa.")));
        }
      },
    );
  }
}
