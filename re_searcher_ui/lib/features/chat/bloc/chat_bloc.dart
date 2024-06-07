import 'package:bloc/bloc.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/model/conversation.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<SetActiveDocumentEvent>((event, emit) {
      emit(state.copyWith(currentDocument: event.document));
    });

    on<DeleteNoteEvent>((event, emit) {
      final currentDocument = state.currentDocument;
      final stickyNotesByActiveDocument = state.stickyNotesByActiveDocument;
      final visibleNotes = state.visibleNotes;

      visibleNotes.remove(event.note);
      if (currentDocument != null) {
        stickyNotesByActiveDocument[currentDocument] = visibleNotes;
      }

      emit(
        state.copyWith(
            visibleNotes: visibleNotes,
            stickyNotesByActiveDocument: stickyNotesByActiveDocument),
      );
    });

    on<InitChatBlocEvent>((event, emit) {
      if (state.currentDocument == null) {
        emit(state.copyWith(
            currentDocument: ActiveDocument(
                name: "Don Kihot",
                filename: "don_kihot.pdf",
                description: "Čuvena novela Servantesa.")));
      }
    });
  }
}
