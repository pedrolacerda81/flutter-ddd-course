import 'package:dartz/dartz.dart';
import 'package:notes_ddd_course/domain/core/errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_ddd_course/domain/core/failures.dart';

@immutable
abstract class ValueObject<T> {
  Either<ValueFailure<T>, T> get value;
  const ValueObject();

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() => value.fold((f) => throw UnexpectedValueError(f), id);
  // id = identity - same as writing (right) => rigth

  bool isValid() => value.isRight();

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ValueObject<T> && o.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'ValueObject(value: $value)';
}
