import 'package:bloc/bloc.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatState()) {
    on<SetActiveDocumentEvent>((event, emit) {
      emit(state.copyWith(currentDocument: event.document));
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
