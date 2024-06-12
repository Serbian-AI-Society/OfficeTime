import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';

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
      buildWhen: (previous, current) =>
          previous.messageSuggestions != current.messageSuggestions,
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
