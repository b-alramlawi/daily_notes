import '../../../../core/database/database_helper.dart';
import '../models/note_model.dart';

class NoteDataSource {
  final DatabaseHelper databaseHelper;

  NoteDataSource(this.databaseHelper);

  Future<List<NoteModel>> getAllNotes() => databaseHelper.getNotes();
  Future<int> addNote(NoteModel note) => databaseHelper.insert(note);
  Future<int> updateNote(NoteModel note) => databaseHelper.update(note);
  Future<int> deleteNoteById(int id) => databaseHelper.delete(id);
}
