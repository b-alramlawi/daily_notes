import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/strings.dart';
import '../../domain/entities/note.dart';
import '../providers/note_provider.dart';

class NoteDialog extends StatelessWidget {
  final Note? note;

  NoteDialog({super.key, this.note});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (note != null) {
      _titleController.text = note!.title;
      _contentController.text = note!.content;
    }

    return AlertDialog(
      title: Text(note == null
          ? DailyNotesStrings.addNoteTitle
          : DailyNotesStrings.editNoteTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration:
                const InputDecoration(labelText: DailyNotesStrings.titleLabel),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(
                labelText: DailyNotesStrings.contentLabel),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(DailyNotesStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            final title = _titleController.text;
            final content = _contentController.text;

            if (note == null) {
              Provider.of<NoteProvider>(context, listen: false).addNote(
                Note(
                  title: title,
                  content: content,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                ),
              );
            } else {
              Provider.of<NoteProvider>(context, listen: false).updateNote(
                Note(
                  id: note!.id,
                  title: title,
                  content: content,
                  createdAt: note!.createdAt,
                  updatedAt: DateTime.now(),
                ),
              );
            }

            Navigator.of(context).pop();
          },
          child: Text(
              note == null ? DailyNotesStrings.add : DailyNotesStrings.update),
        ),
      ],
    );
  }
}
