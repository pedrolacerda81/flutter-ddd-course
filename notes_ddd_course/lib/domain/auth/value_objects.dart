import 'package:dartz/dartz.dart';
import 'package:notes_ddd_course/domain/core/failures.dart';
import 'package:notes_ddd_course/domain/core/value_objects.dart';
import 'package:notes_ddd_course/domain/core/value_validators.dart';

class EmailAddress extends ValueObject {
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(
      validateEmailAddress(input),
    );
  }

  const EmailAddress._(this.value);
}
