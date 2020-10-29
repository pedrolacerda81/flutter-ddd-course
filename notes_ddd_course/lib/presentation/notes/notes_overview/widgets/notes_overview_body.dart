import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_watcher/note_watch_bloc.dart';

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
                  return Container(
                    color: Colors.redAccent,
                    width: 100.0,
                    height: 100.0,
                  );
                } else {
                  return Container(
                    color: Colors.green[400],
                    width: 100.0,
                    height: 100.0,
                  );
                }
              },
            );
          },
          loadFailure: (state) {
            return Container(
              color: Colors.yellow,
              width: 200.0,
              height: 200.0,
            );
          },
        );
      },
    );
  }
}
