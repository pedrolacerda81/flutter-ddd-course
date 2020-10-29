import 'package:auto_route/auto_route.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_ddd_course/application/auth/auth_bloc.dart';
import 'package:notes_ddd_course/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:notes_ddd_course/presentation/routes/router.gr.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
                    (failure) => FlushbarHelper.createError(
                          message: failure.map(
                              cancelledByUser: (_) => 'Cancelled',
                              serverError: (_) => 'Server error',
                              emailAlreadyInUse: (_) => 'Email already in use',
                              invalidEmailAndPasswordCombination: (_) =>
                                  'Invalid email and password combination'),
                        ).show(context), (_) {
                  ExtendedNavigator.of(context)
                      .replace(Routes.notesOverviewPage);
                  context
                      .bloc<AuthBloc>()
                      .add(const AuthEvent.authCheckRequested());
                }));
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Form(
            autovalidate: state.showErrorMessages,
            child: ListView(
              children: [
                const Text(
                  '📝',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 130.0),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) => context
                      .bloc<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          invalidEmail: (_) => 'Invalid email',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  autocorrect: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  onChanged: (value) => context
                      .bloc<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.bloc<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Short password',
                              orElse: () => null,
                            ),
                            (r) => null,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: FlatButton(
                        onPressed: () => context.bloc<SignInFormBloc>().add(
                            const SignInFormEvent
                                .signInWithEmailAndPasswordPressed()),
                        child: const Text('SIGN IN'),
                      ),
                    ),
                    Expanded(
                      child: FlatButton(
                        onPressed: () => context.bloc<SignInFormBloc>().add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed()),
                        child: const Text('REGISTER'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                RaisedButton(
                  onPressed: () => context
                      .bloc<SignInFormBloc>()
                      .add(const SignInFormEvent.signInWithGooglePressed()),
                  color: Colors.lightBlue,
                  child: const Text(
                    'SIGN IN WITH GOOGLE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (state.isSubmitting) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
