part of 'note_watch_bloc.dart';

@freezed
abstract class NoteWatchEvent with _$NoteWatchEvent {
  const factory NoteWatchEvent.watchAllStarted() = _WatchAllStarted;
  const factory NoteWatchEvent.watchUncompletedStarted() =
      _WatchUncompletedStarted;
  const factory NoteWatchEvent.notesReceived(
    Either<NoteFailure, KtList<Note>> failureOrNotes,
  ) = _NotesReceived;
}
