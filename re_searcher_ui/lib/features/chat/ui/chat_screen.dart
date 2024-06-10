import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/chat_container.dart';
import 'package:re_searcher_ui/features/chat/ui/notes/notes_container.dart';
import 'package:re_searcher_ui/features/home/ui/side_menu.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _bloc = IC.getIt<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    _bloc.add(InitChatBlocEvent());
    return Scaffold(
      backgroundColor: mediumGray,
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            children: [
              SideMenu(),
              ChatBody(activeDocument: state.currentDocument)
            ],
          );
        },
      ),
    );
  }
}

class ChatBody extends StatelessWidget {
  const ChatBody({
    super.key,
    required this.activeDocument,
  });

  final ActiveDocument? activeDocument;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activeDocument?.name! ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: white, fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  activeDocument?.description! ?? "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: white, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 2,
                    child: ChatContainer(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    flex: 1,
                    child: NotesContainer(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
