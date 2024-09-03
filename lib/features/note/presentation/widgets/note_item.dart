import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/color.dart';
import '../../../../core/theme/strings.dart';
import '../../domain/entities/note.dart';
import '../providers/note_provider.dart';
import 'note_dialog.dart';

class NoteItem extends StatefulWidget {
  final Note note;

  const NoteItem({super.key, required this.note});

  @override
  NoteItemState createState() => NoteItemState();
}

class NoteItemState extends State<NoteItem> {
  double _horizontalMargin = 16.0;

  @override
  Widget build(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);

    return Dismissible(
      key: ValueKey(widget.note.id),
      background: _buildSwipeBackground(
          Colors.red, Icons.delete, Alignment.centerRight),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {},
      onUpdate: (details) {
        setState(() {
          _horizontalMargin = details.progress > 0.0 ? 0.0 : 16.0;
        });
      },
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => NoteDialog(note: widget.note),
          );
        },
        child: Card(
          elevation: 2,
          margin:
              EdgeInsets.symmetric(vertical: 8, horizontal: _horizontalMargin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          color: DailyNotesColors.lightMint,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Container(
              decoration: const BoxDecoration(
                color: DailyNotesColors.lightMint,
                border: Border(
                  left: BorderSide(
                    color: DailyNotesColors.black,
                    width: 5,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.note.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.blueGrey[800],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.note.content,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              formatDateTime(widget.note.updatedAt),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final confirmDelete = await showConfirmDeleteDialog(context);
          if (confirmDelete == true) {
            noteProvider.deleteNoteById(widget.note.id!);
            return true;
          }
          return false;
        }
        return false;
      },
    );
  }

  Widget _buildSwipeBackground(
      Color color, IconData icon, AlignmentGeometry alignment) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: color,
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(
            icon,
            color: DailyNotesColors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    final hours = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM';

    final date =
        '${dateTime.day.toString().padLeft(2, '0')}-${(dateTime.month).toString().padLeft(2, '0')}-${dateTime.year}';

    return '$date $hours:$minutes $amPm';
  }

  Future<bool?> showConfirmDeleteDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(DailyNotesStrings.confirmDeletionTitle),
        content: const Text(DailyNotesStrings.confirmDeletionContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(DailyNotesStrings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(DailyNotesStrings.delete),
          ),
        ],
      ),
    );
  }
}
