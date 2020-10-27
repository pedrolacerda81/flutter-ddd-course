import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:notes_ddd_course/domain/core/value_objects.dart';
import 'package:notes_ddd_course/domain/notes/todo_item.dart';
import 'package:notes_ddd_course/domain/notes/value_objects.dart';

part 'notes_dtos.freezed.dart';
part 'notes_dtos.g.dart';

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  const TodoItemDto._();

  const factory TodoItemDto({
    @required String id,
    @required String name,
    @required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
