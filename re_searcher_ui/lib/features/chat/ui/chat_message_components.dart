import 'package:flutter/material.dart';
import 'package:re_searcher_ui/core/model/conversation.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

class UserChatMessage extends StatelessWidget {
  const UserChatMessage(this.message, {super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: mediumGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border(
                right: BorderSide(width: 10, color: lightGreen),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                message.content ?? "",
                style: const TextStyle(color: pureWhite),
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AiChatMessage extends StatelessWidget {
  const AiChatMessage(this.message, {super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.7,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            decoration: const BoxDecoration(
              color: mediumGray,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border(
                left: BorderSide(width: 10, color: white),
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
    );
  }
}

class ErrorChatMessage extends StatelessWidget {
  const ErrorChatMessage(this.message, {super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
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
    );
  }
}
