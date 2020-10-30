import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_watcher/note_watch_bloc.dart';
import 'package:notes_ddd_course/presentation/notes/notes_overview/widgets/critical_failure_display.dart';
import 'package:notes_ddd_course/presentation/notes/notes_overview/widgets/error_note_card.dart';
import 'package:notes_ddd_course/presentation/notes/notes_overview/widgets/note_card.dart';

class NotesOverviewBody extends StatelessWidget {
  const NotesOverviewBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteWatchBloc, NoteWatchState>(
      builder: (context, state) {
        return state.map(
          initial: (_) => Container(),
          loadInProgress: (_) =>
              const Center(child: CircularProgressIndicator()),
          loadSuccess: (state) {
            return ListView.builder(
              itemCount: state.notes.size,
              itemBuilder: (context, index) {
                final note = state.notes[index];
                if (note.optionFailure.isSome()) {
                  return ErrorNoteCard(note: note);
                } else {
                  return NoteBody(note: note);
                }
              },
            );
          },
          loadFailure: (state) {
            return CriticalFailureDisplay(failure: state.noteFailure);
          },
        );
      },
    );
  }
}
