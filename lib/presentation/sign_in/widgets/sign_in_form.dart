import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () {},
          (either) => either.fold(
            (f) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(f.map(
                      cancelledByUser: (_) => 'Cancelled',
                      serverError: (_) => 'Server error',
                      emailAlredyInUse: (_) => 'Email already in use',
                      invalidEmailAndPasswordCombination: (_) =>
                          'Invalid email and password'))));
            },
            (_) {
              // TODO Navigate to Home Page
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.validateMode,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                const Text(
                  '📝',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 120),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                  autocorrect: false,
                  onChanged: (value) {
                    context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.emailChanged(value));
                  },
                  validator: (_) => context
                      .read<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                            orElse: () => null,
                            invalidEmail: (_) => 'Invalid Email'),
                        (_) => null,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                  autocorrect: false,
                  onChanged: (value) {
                    context
                        .read<SignInFormBloc>()
                        .add(SignInFormEvent.passwordChanged(value));
                  },
                  validator: (_) =>
                      context.read<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              orElse: () => null,
                              shortPassword: (_) => 'Short Password',
                            ),
                            (_) => null,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      child: const Text('SIGN IN'),
                      onPressed: () {
                        context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed(),
                            );
                      },
                    ),
                    TextButton(
                      child: const Text('REGISTER'),
                      onPressed: () {
                        context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .registerWithEmailAndPasswordPressed(),
                            );
                      },
                    )
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  child: const Text('SIGN IN WITH GOOGLE'),
                  onPressed: () {
                    context.read<SignInFormBloc>().add(
                          const SignInFormEvent.signInWithGooglePressed(),
                        );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
