import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/active_document.dart';
import 'package:re_searcher_ui/core/model/chat_message.dart';
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

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  bool _isMessagesEmpty = true;
  List<ChatMessage> _messages = [];
  ActiveDocument? _activeDocument;

  void _addMessage(ChatMessage message) {
    _messages.add(message);
    setState(() {
      _isMessagesEmpty = false;
    });
    _listKey.currentState?.insertItem(0);
  }

  void _setDocument(ActiveDocument? document) {
    setState(() {
      _activeDocument = document;
    });
  }

  void _setAllMessages(List<ChatMessage> messages) {
    _listKey.currentState?.removeAllItems((context, animation) => Container());
    setState(() {
      _messages = messages;
    });

    _listKey.currentState
        ?.insertAllItems(0, _messages.length, duration: Durations.short1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: darkGray,
        border: Border.all(width: 2, color: lightGray),
      ),
      child: BlocListener<ChatBloc, ChatState>(
        bloc: _bloc,
        child: FractionallySizedBox(
          widthFactor: 0.95,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    if (_isMessagesEmpty)
                      NoMessagesContainer(
                          filename: _activeDocument?.filename ?? "null"),
                    AnimatedList(
                      initialItemCount: _messages.length,
                      reverse: true,
                      key: _listKey,
                      itemBuilder: (context, index, animation) {
                        var message = (_messages.reversed.toList())[index];
                        StatelessWidget bodyWidget;

                        if (message.role == "user") {
                          bodyWidget = UserChatMessage(message);
                        } else if (message.role == "assistant") {
                          bodyWidget = AiChatMessage(message);
                        } else {
                          bodyWidget = ErrorChatMessage(message);
                        }

                        return _getChatMessageWidget(
                            bodyWidget, message.role ?? "user", animation);
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
        // listenWhen: (previous, current) =>
        //     previous.visibleMessages.length != current.visibleMessages.length ||
        //     current.currentDocument?.filename !=
        //         previous.currentDocument?.filename,
        listener: (context, state) {
          if (_activeDocument?.filename != state.currentDocument?.filename) {
            _setDocument(state.currentDocument);
            _setAllMessages(state.visibleMessages);
          } else if (_messages.length < state.visibleMessages.length) {
            _addMessage(state.visibleMessages.last);
            // for (int i = _messages.length;
            //     i < state.visibleMessages.length;
            //     i++) {
            //   _addMessage(state.visibleMessages[i]);
            // }
          }
        },
      ),
    );
  }

  Widget _getChatMessageWidget(
      Widget body, String author, Animation<double> animation) {
    var alignment =
        (author == "user") ? Alignment.centerRight : Alignment.centerLeft;

    return SizeTransition(
      sizeFactor: animation,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: body,
        ),
      ),
    );
  }
}
