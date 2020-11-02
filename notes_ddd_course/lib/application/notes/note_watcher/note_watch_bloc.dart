import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_ddd_course/domain/notes/i_note_repository.dart';
import 'package:notes_ddd_course/domain/notes/note.dart';
import 'package:notes_ddd_course/domain/notes/note_failure.dart';
part 'note_watch_event.dart';
part 'note_watch_state.dart';
part 'note_watch_bloc.freezed.dart';

@injectable
class NoteWatchBloc extends Bloc<NoteWatchEvent, NoteWatchState> {
  final INoteRepository _noteRepository;

  NoteWatchBloc(this._noteRepository) : super(const NoteWatchState.initial());

  StreamSubscription<Either<NoteFailure, KtList<Note>>> _noteStreamSubscription;

  @override
  Stream<NoteWatchState> mapEventToState(
    NoteWatchEvent event,
  ) async* {
    yield* event.map(
      watchAllStarted: (e) async* {
        yield const NoteWatchState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchAll().listen(
            (notesOrFailure) =>
                add(NoteWatchEvent.notesReceived(notesOrFailure)));
      },
      watchUncompletedStarted: (e) async* {
        yield const NoteWatchState.loadInProgress();
        await _noteStreamSubscription?.cancel();
        _noteStreamSubscription = _noteRepository.watchUncompleted().listen(
            (notesOrFailure) =>
                add(NoteWatchEvent.notesReceived(notesOrFailure)));
      },
      notesReceived: (e) async* {
        yield e.failureOrNotes.fold(
          (f) => NoteWatchState.loadFailure(f),
          (notes) => NoteWatchState.loadSuccess(notes),
        );
      },
    );
  }

  @override
  Future<void> close() async {
    await _noteStreamSubscription?.cancel();
    return super.close();
  }
}
