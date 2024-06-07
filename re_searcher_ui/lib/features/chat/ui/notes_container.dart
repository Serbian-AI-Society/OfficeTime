import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';

class NotesContainer extends StatelessWidget {
  NotesContainer({super.key});

  final _bloc = IC.getIt<ChatBloc>();

  void _deleteNote(StickyNote note, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Beleška obrisana!"),
      ),
    );
    _bloc.add(DeleteNoteEvent(note: note));
  }

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: BlocConsumer<ChatBloc, ChatState>(
              bloc: _bloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Beleške",
                      style: TextStyle(
                          fontSize: 20,
                          color: white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    if (state.visibleNotes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30, horizontal: 20),
                        child: Column(
                          children: [
                            SvgPicture.asset(
                              "assets/Doc.svg",
                              color: lightGray,
                              width: 40,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Nemate beleški! Zamolite AI da kreira belešku za vas! 😄🧠",
                              style: TextStyle(color: lightGray, fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    else
                      ...state.visibleNotes.map(
                        (note) => NoteCard(
                          note: note,
                          onDelete: () {
                            _deleteNote(note, context);
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    required this.onDelete,
  });

  final StickyNote note;
  final Function() onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: const BoxDecoration(
          color: darkYellow,
          border: Border(
            left: BorderSide(width: 10, color: mediumYellow),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    note.title ?? "",
                    style: const TextStyle(
                        color: pureWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        onDelete();
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: white,
                      ))
                ],
              ),
              Text(
                note.description ?? "",
                style: const TextStyle(color: white, fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                note.timestamp ?? "",
                style: const TextStyle(color: mediumYellow, fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
