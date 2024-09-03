import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_data_source.dart';
import '../models/note_model.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource noteDataSource;

  NoteRepositoryImpl(this.noteDataSource);

  @override
  Future<List<Note>> getAllNotes() {
    return noteDataSource.getAllNotes();
  }

  @override
  Future<int> addNote(Note note) {
    final noteModel = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    return noteDataSource.addNote(noteModel);
  }

  @override
  Future<int> updateNote(Note note) {
    final noteModel = NoteModel(
      id: note.id,
      title: note.title,
      content: note.content,
      createdAt: note.createdAt,
      updatedAt: DateTime.now(),
    );
    return noteDataSource.updateNote(noteModel);
  }

  @override
  Future<int> deleteNoteById(int id) {
    return noteDataSource.deleteNoteById(id);
  }
}
