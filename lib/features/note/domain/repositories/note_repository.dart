import '../entities/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getAllNotes();
  Future<int> addNote(Note note);
  Future<int> updateNote(Note note);
  Future<int> deleteNoteById(int id);
}
