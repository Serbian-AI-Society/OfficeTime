import 'package:flutter/widgets.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

class NotesContainer extends StatelessWidget {
  const NotesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: darkGray,
          border: Border.all(width: 3, color: lightGray),
        ),
        child: const Text("Chat"),
      ),
    );
  }
}
