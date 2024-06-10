import 'package:flutter/material.dart';
import 'package:re_searcher_ui/core/model/chat_message.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

class ErrorChatMessage extends StatelessWidget {
  const ErrorChatMessage(this.message, {super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      focusNode: FocusNode(),
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: const BoxDecoration(
                color: darkRed,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                border: Border(
                  left: BorderSide(width: 10, color: mediumRed),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  message.content ?? "",
                  style: const TextStyle(color: pureWhite),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
