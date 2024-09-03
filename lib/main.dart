import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/database/database_helper.dart';
import 'core/theme/color.dart';
import 'core/theme/strings.dart';
import 'features/note/data/datasources/note_data_source.dart';
import 'features/note/data/repositories/note_repository_impl.dart';
import 'features/note/domain/usecases/crud_note_usecases.dart';
import 'features/note/presentation/providers/note_provider.dart';
import 'features/note/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final databaseHelper = DatabaseHelper();
    final noteDataSource = NoteDataSource(databaseHelper);
    final noteRepository = NoteRepositoryImpl(noteDataSource);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NoteProvider(
            getNotesUseCase: GetNotes(noteRepository),
            addNoteUseCase: AddNote(noteRepository),
            updateNoteUseCase: UpdateNote(noteRepository),
            deleteNoteUseCase: DeleteNote(noteRepository),
          )..fetchNotes(),
        ),
      ],
      child: MaterialApp(
        title: DailyNotesStrings.appTitle,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: DailyNotesColors.tealGreen),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
