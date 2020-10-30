import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_actor/note_actor_bloc.dart';
import 'package:notes_ddd_course/domain/notes/note.dart';
import 'package:kt_dart/collection.dart';
import 'package:notes_ddd_course/domain/notes/todo_item.dart';

class NoteBody extends StatelessWidget {
  final Note note;
  const NoteBody({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: note.color.getOrCrash(),
      child: InkWell(
        onLongPress: () {
          final noteActorBloc = context.bloc<NoteActorBloc>();
          _showDeletionDialog(context: context, noteActorBloc: noteActorBloc);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.body.getOrCrash(),
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              if (note.todos.length > 0) ...[
                const SizedBox(height: 4),
                Wrap(
                  spacing: 8,
                  children: [
                    ...note.todos
                        .getOrCrash()
                        .map(
                          (todo) => TodoDisplay(todo: todo),
                        )
                        .iter
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  void _showDeletionDialog(
      {@required BuildContext context, @required NoteActorBloc noteActorBloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Selected note'),
            content: Text(
              note.body.getOrCrash(),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.grey[400]),
                ),
              ),
              FlatButton(
                onPressed: () {
                  noteActorBloc.add(NoteActorEvent.deleted(note));
                  Navigator.pop(context);
                },
                child: const Text(
                  'DELETE',
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
          );
        });
  }
}

class TodoDisplay extends StatelessWidget {
  final TodoItem todo;
  const TodoDisplay({
    Key key,
    @required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (todo.done)
          Icon(
            Icons.check_box_rounded,
            color: Theme.of(context).accentColor,
          ),
        if (!todo.done)
          Icon(
            Icons.check_box_outline_blank_rounded,
            color: Theme.of(context).disabledColor,
          ),
        Text(todo.name.getOrCrash())
      ],
    );
  }
}
