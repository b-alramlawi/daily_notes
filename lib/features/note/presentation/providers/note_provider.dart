import 'package:flutter/cupertino.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/crud_note_usecases.dart';

class NoteProvider extends ChangeNotifier {
  final GetNotes getNotesUseCase;
  final AddNote addNoteUseCase;
  final UpdateNote updateNoteUseCase;
  final DeleteNote deleteNoteUseCase;

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NoteProvider({
    required this.getNotesUseCase,
    required this.addNoteUseCase,
    required this.updateNoteUseCase,
    required this.deleteNoteUseCase,
  });

  Future<void> fetchNotes() async {
    _notes = await getNotesUseCase();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await addNoteUseCase(note);
    await fetchNotes();
  }

  Future<void> updateNote(Note note) async {
    await updateNoteUseCase(note);
    await fetchNotes();
  }

  Future<void> deleteNoteById(int id) async {
    await deleteNoteUseCase(id);
    await fetchNotes();
  }
}
