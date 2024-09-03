import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNotes {
  final NoteRepository repository;

  GetNotes(this.repository);

  Future<List<Note>> call() {
    return repository.getAllNotes();
  }
}

class AddNote {
  final NoteRepository repository;

  AddNote(this.repository);

  Future<int> call(Note note) {
    return repository.addNote(note);
  }
}

class UpdateNote {
  final NoteRepository repository;

  UpdateNote(this.repository);

  Future<int> call(Note note) {
    return repository.updateNote(note);
  }
}

class DeleteNote {
  final NoteRepository repository;

  DeleteNote(this.repository);

  Future<int> call(int id) {
    return repository.deleteNoteById(id);
  }
}
