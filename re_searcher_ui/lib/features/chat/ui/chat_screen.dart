import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/home/ui/side_menu.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _bloc = IC.getIt<ChatBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mediumGray,
      body: BlocConsumer<ChatBloc, ChatState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) {
          return Row(
            children: [
              SideMenu(),
              Text(
                state.currentDocument?.name! ?? "Nista",
                style: const TextStyle(color: white),
              ),
            ],
          );
        },
      ),
    );
  }
}
