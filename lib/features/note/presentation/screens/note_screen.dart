import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/color.dart';
import '../../../../core/theme/strings.dart';
import '../providers/note_provider.dart';
import '../widgets/note_dialog.dart';
import '../widgets/note_item.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({super.key});

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  String _searchQuery = '';
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DailyNotesColors.tealGreen,
        title: const Center(child: Text(DailyNotesStrings.appTitle)),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          final filteredNotes = noteProvider.notes.where((note) {
            final lowerCaseQuery = _searchQuery.toLowerCase();
            final lowerCaseTitle = note.title.toLowerCase();
            final lowerCaseContent = note.content.toLowerCase();
            return lowerCaseTitle.contains(lowerCaseQuery) ||
                lowerCaseContent.contains(lowerCaseQuery);
          }).toList();

          // Sort the filtered notes
          filteredNotes.sort((a, b) {
            final comparison = a.title.compareTo(b.title);
            return _sortAscending ? comparison : -comparison;
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: DailyNotesStrings.searchHint,
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (query) {
                    setState(() {
                      _searchQuery = query;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: DailyNotesColors.tealGreen,
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.sort,
                        size: 20,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          _sortAscending = !_sortAscending;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredNotes.length,
                  itemBuilder: (context, index) {
                    final note = filteredNotes[index];
                    return NoteItem(note: note);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => NoteDialog(),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
