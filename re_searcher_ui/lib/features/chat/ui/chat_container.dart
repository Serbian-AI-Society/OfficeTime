import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/conversation.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/chat/ui/chat_message_components.dart';

class ChatContainer extends StatefulWidget {
  const ChatContainer({super.key});

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  final _bloc = IC.getIt<ChatBloc>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<ChatMessage> _messages = [];

  void _addMessage(ChatMessage message) {
    _messages.add(message);
    _listKey.currentState?.insertItem(0);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkGray,
        border: Border.all(width: 3, color: lightGray),
      ),
      child: BlocConsumer<ChatBloc, ChatState>(
        bloc: _bloc,
        builder: (context, state) => SelectionArea(
          focusNode: FocusNode(),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              widthFactor: 0.95,
              alignment: Alignment.bottomCenter,
              child: ListView.builder(
                itemCount: state.visibleMessages.length,
                reverse: true,
                itemBuilder: (context, index) {
                  var message =
                      (state.visibleMessages.reversed.toList())[index];
                  StatelessWidget bodyWidget;

                  if (message.role == "user") {
                    bodyWidget = UserChatMessage(message);
                  } else if (message.role == "assistant") {
                    bodyWidget = AiChatMessage(message);
                  } else {
                    bodyWidget = ErrorChatMessage(message);
                  }

                  return getChatMessageWidget(
                      bodyWidget, message.role ?? "user");
                },
              ),
            ),
          ),
        ),
        listener: (context, state) {},
      ),
    );
  }
}

Widget getChatMessageWidget(Widget body, String author) {
  var alignment =
      (author == "user") ? Alignment.centerRight : Alignment.centerLeft;

  return Align(
    alignment: alignment,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: body,
    ),
  );
}
