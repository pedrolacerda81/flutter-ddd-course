import 'package:flutter/material.dart';
import 'package:notes_ddd_course/domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;
  const CriticalFailureDisplay({
    Key key,
    @required this.failure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '😱',
            style: TextStyle(fontSize: 100.0),
          ),
          Text(
            failure.maybeMap(
              insufficientPermission: (_) => 'Insufficient permition',
              orElse: () => 'Unexpected error.\nPlease contect support.',
            ),
            style: const TextStyle(fontSize: 24.0),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () {
              debugPrint('Sending email!');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.mail),
                SizedBox(width: 4),
                Text('I NEED HELP'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
