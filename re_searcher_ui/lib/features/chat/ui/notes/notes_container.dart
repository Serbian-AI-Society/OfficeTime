import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:re_searcher_ui/core/injection_container.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';
import 'package:re_searcher_ui/features/chat/bloc/chat_bloc.dart';
import 'package:re_searcher_ui/features/chat/ui/notes/no_notes_container.dart';
import 'package:re_searcher_ui/features/chat/ui/notes/note_card.dart';

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
          border: Border.all(width: 2, color: lightGray),
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
                      const NoNotesContainer()
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
