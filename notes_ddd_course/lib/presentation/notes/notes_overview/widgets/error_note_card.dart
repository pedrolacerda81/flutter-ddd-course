import 'package:flutter/material.dart';
import 'package:notes_ddd_course/domain/notes/note.dart';

class ErrorNoteCard extends StatelessWidget {
  final Note note;
  const ErrorNoteCard({Key key, @required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).errorColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '✖️',
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Invalid Note!',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        .copyWith(fontSize: 20.0),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Please, contact support.',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyText2
                        .copyWith(fontSize: 12.0),
                  ),
                  const SizedBox(height: 4.0),
                  Wrap(
                    children: [
                      Text(
                        'Details for nerds: ',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2
                            .copyWith(fontSize: 12.0),
                      ),
                      Text(
                        note.optionFailure.fold(() => '', (f) => f.toString()),
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyText2
                            .copyWith(
                              fontSize: 11.0,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
