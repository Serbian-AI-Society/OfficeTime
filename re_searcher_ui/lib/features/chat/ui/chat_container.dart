import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
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
        border: Border.all(width: 2, color: lightGray),
      ),
      child: BlocConsumer<ChatBloc, ChatState>(
        bloc: _bloc,
        builder: (context, state) => FractionallySizedBox(
          widthFactor: 0.95,
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              if (state.visibleMessages.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          "assets/Send.svg",
                          color: lightGray,
                          width: 60,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          "Nema poruka! Započnite dopisivanje o dokumentu '${state.currentDocument?.filename ?? "null"}'",
                          style:
                              const TextStyle(color: lightGray, fontSize: 24),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                )
              else
                Expanded(
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
              MessageSuggestions(),
              const ChatTextField()
            ],
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

class MessageSuggestions extends StatelessWidget {
  MessageSuggestions({super.key});

  final _bloc = IC.getIt<ChatBloc>();

  void _sendMessage(String message) async {
    if (!_bloc.state.isLoading) {
      _bloc.add(SendMessageEvet(message: message));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state.messageSuggestions != null ||
            state.messageSuggestions!.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...state.messageSuggestions!.map(
                    (message) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ActionChip(
                        backgroundColor: mediumGreen,
                        label: Text(message),
                        onPressed: () {
                          _sendMessage(message);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class ChatTextField extends StatefulWidget {
  const ChatTextField({super.key});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  final _bloc = IC.getIt<ChatBloc>();

  final _textController = TextEditingController();

  late bool isEmpty;

  @override
  void initState() {
    super.initState();
    isEmpty = true;
  }

  void _sendMessage() async {
    var text = _textController.text;
    if (text.trim() != "") {
      _bloc.add(SendMessageEvet(message: text.trim()));
      await Future.delayed(const Duration(milliseconds: 1));
      setState(() {
        _textController.clear();
        isEmpty = true;
      });
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      bloc: _bloc,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: RawKeyboardListener(
            onKey: (event) {
              if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
                  !state.isLoading) {
                _sendMessage();
              }
            },
            focusNode: FocusNode(),
            child: TextField(
              controller: _textController,
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  isEmpty = value.isEmpty;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: mediumGray,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: lightGray, width: 2),
                ),
                hintText: "Unesite svoje pitanje...",
                hintStyle: const TextStyle(color: Colors.white),
                suffixIcon: IconButton(
                  icon: (!state.isLoading)
                      ? const Icon(Icons.send)
                      : const SizedBox.square(
                          dimension: 20, child: CircularProgressIndicator()),
                  color: white,
                  onPressed: (isEmpty)
                      ? null
                      : () {
                          _sendMessage();
                        },
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
