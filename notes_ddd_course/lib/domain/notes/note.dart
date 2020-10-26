import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_ddd_course/domain/core/failures.dart';
import 'package:notes_ddd_course/domain/core/value_objects.dart';
import 'package:notes_ddd_course/domain/notes/todo_item.dart';
import 'package:notes_ddd_course/domain/notes/value_objects.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const Note._();

  const factory Note({
    @required UniqueId id,
    @required NoteBody body,
    @required NoteColor color,
    @required List3<TodoItem> toDos,
  }) = _Note;

  factory Note.empty() => Note(
        id: UniqueId(),
        body: NoteBody(''),
        color: NoteColor(NoteColor.predefinedColors[0]),
        toDos: List3(emptyList()),
      );

  Option<ValueFailure<dynamic>> get optionFailure => body.failureOrUnit
      .andThen(toDos.failureOrUnit)
      .andThen(
        toDos
            .getOrCrash()
            // Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
            .map((todoItem) => todoItem.failureOption)
            .filter((o) => o.isSome())
            // If we can't get the 0th element, the list is empty. In such a case, it's valid.
            .getOrElse(0, (_) => none())
            .fold(() => right(unit), (f) => left(f)),
      )
      .fold((f) => some(f), (_) => none());
}
