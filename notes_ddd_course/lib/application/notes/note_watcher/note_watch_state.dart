part of 'note_watch_bloc.dart';

@freezed
abstract class NoteWatchState with _$NoteWatchState {
  const factory NoteWatchState.initial() = _Initial;
  const factory NoteWatchState.loadInProgress() = _LoadInProgress;
  const factory NoteWatchState.loadSuccess(KtList<Note> notes) = _LoadSuccess;
  const factory NoteWatchState.loadFailure(NoteFailure noteFailure) =
      _LoadFailure;
}
