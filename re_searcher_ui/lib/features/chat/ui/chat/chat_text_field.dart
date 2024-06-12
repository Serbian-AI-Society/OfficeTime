import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';

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
      buildWhen: (previous, current) => previous.isLoading != current.isLoading,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: KeyboardListener(
            onKeyEvent: (event) {
              if (event.logicalKey == (LogicalKeyboardKey.enter) &&
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
                      ? const Icon(
                          Icons.send,
                          color: primaryGreen,
                        )
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
