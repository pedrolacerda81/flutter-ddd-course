import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:notes_ddd_course/domain/auth/user.dart';
import 'package:notes_ddd_course/domain/core/value_objects.dart';

extension FirebaseUserDomainX on firebase.User {
  User toDomain() => User(id: UniqueId.fromUniqueString(uid));
}
