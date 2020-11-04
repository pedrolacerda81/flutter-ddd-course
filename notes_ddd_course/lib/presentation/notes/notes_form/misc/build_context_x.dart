import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kt_dart/kt.dart';
import 'package:notes_ddd_course/presentation/notes/notes_form/misc/todo_item_presentation_classes.dart';
import 'package:provider/provider.dart';

extension FormTodosX on BuildContext {
  KtList<TodoItemPrimitive> get formTodos =>
      Provider.of<FormTodos>(this, listen: false).value;
  set formTodos(KtList<TodoItemPrimitive> value) =>
      Provider.of<FormTodos>(this, listen: false).value = value;
}
