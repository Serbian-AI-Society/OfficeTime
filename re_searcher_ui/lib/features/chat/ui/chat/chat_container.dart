import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/ai_message.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/chat_text_field.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/error_message.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/message_suggestions.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/no_messages_container.dart';
import 'package:re_searcher_ui/features/chat/ui/chat/user_message.dart';

// ignore: must_be_immutable
class ChatContainer extends StatefulWidget {
  const ChatContainer({super.key});

  @override
  State<ChatContainer> createState() => _ChatContainerState();
}

class _ChatContainerState extends State<ChatContainer> {
  final _bloc = IC.getIt<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkGray,
        border: Border.all(width: 2, color: lightGray),
      ),
      child: BlocBuilder<ChatBloc, ChatState>(
        bloc: _bloc,
        builder: (context, state) => FractionallySizedBox(
          widthFactor: 0.95,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (state.visibleMessages.isEmpty)
                      NoMessagesContainer(
                          filename: state.currentDocument?.filename ?? "null"),
                    ListView.builder(
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

                        return _getChatMessageWidget(
                            bodyWidget, message.role ?? "user");
                      },
                    ),
                  ],
                ),
              ),
              MessageSuggestions(),
              const ChatTextField()
            ],
          ),
        ),
      ),
    );
  }

  Widget _getChatMessageWidget(Widget body, String author) {
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
}
