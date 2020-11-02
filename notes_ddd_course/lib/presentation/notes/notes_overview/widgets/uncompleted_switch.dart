import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:notes_ddd_course/application/notes/note_watcher/note_watch_bloc.dart';

class UncompletedSwitch extends HookWidget {
  const UncompletedSwitch({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toggleState = useState(false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: InkResponse(
        onTap: () {
          toggleState.value = !toggleState.value;
          context.bloc<NoteWatchBloc>().add(toggleState.value
              ? const NoteWatchEvent.watchUncompletedStarted()
              : const NoteWatchEvent.watchAllStarted());
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: toggleState.value
              ? const Icon(
                  Icons.check_box_outline_blank,
                  key: Key('outline'),
                )
              : const Icon(
                  Icons.indeterminate_check_box,
                  key: Key('indeterminate'),
                ),
        ),
      ),
    );
  }
}
