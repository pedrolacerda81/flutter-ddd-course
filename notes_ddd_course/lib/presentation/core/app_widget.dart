import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/auth/auth_bloc.dart';
import 'package:notes_ddd_course/presentation/routes/router.gr.dart';
import '../../injection.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
      ],
      child: MaterialApp(
        title: 'Notes on DDD',
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.green[800],
          accentColor: Colors.blueAccent,
          floatingActionButtonTheme:
              FloatingActionButtonThemeData(backgroundColor: Colors.blue[900]),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        builder: ExtendedNavigator(router: Router()),
      ),
    );
  }
}
