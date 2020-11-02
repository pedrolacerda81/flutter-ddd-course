import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/auth/auth_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_actor/note_actor_bloc.dart';
import 'package:notes_ddd_course/application/notes/note_watcher/note_watch_bloc.dart';
import 'package:notes_ddd_course/injection.dart';
import 'package:notes_ddd_course/presentation/notes/notes_overview/widgets/notes_overview_body.dart';
import 'package:notes_ddd_course/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:notes_ddd_course/presentation/routes/router.gr.dart';

class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NoteWatchBloc>(
          create: (context) => getIt<NoteWatchBloc>()
            ..add(const NoteWatchEvent.watchAllStarted()),
        ),
        BlocProvider<NoteActorBloc>(create: (context) => getIt<NoteActorBloc>())
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            state.maybeMap(
              orElse: () {},
              unauthenticated: (_) =>
                  ExtendedNavigator.of(context).replace(Routes.signInPage),
            );
          }),
          BlocListener<NoteActorBloc, NoteActorState>(
            listener: (context, state) {
              state.maybeMap(
                  orElse: () {},
                  deleteFailure: (state) {
                    FlushbarHelper.createError(
                      duration: const Duration(seconds: 5),
                      message: state.noteFailure.map(
                        unexpected: (_) =>
                            'Unexpected error occured while deleting, please contact support.',
                        insufficientPermission: (_) =>
                            'Insufficient permissions ⛔',
                        unableToUpdate: (_) => 'Impossible error.',
                        unableToDelete: (_) => 'Impossible error.',
                      ),
                    ).show(context);
                  });
            },
          )
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.bloc<AuthBloc>().add(const AuthEvent.signedOut());
              },
            ),
            actions: [
              const UncompletedSwitch(),
            ],
          ),
          body: const NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //TODO: navigate to notes form page
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
