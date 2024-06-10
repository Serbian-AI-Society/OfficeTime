import 'package:flutter/material.dart';
import 'package:re_searcher_ui/core/model/sticky_note.dart';
import 'package:re_searcher_ui/core/ui/colors.dart';

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
