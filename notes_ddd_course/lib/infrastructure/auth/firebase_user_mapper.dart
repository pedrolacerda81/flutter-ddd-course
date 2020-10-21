import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_ddd_course/domain/auth/user.dart';
import 'package:notes_ddd_course/domain/core/value_objects.dart';

extension FirebaseUserDomainX on FirebaseUser {
  User toDomain() => User(id: UniqueId.fromUniqueString(uid));
}
