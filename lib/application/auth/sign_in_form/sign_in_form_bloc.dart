import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/auth/auth_failure.dart';
import '../../../domain/auth/i_auth_facade.dart';
import '../../../domain/auth/value_objects.dart';

part 'sign_in_form_bloc.freezed.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>((event, emit) {
      event.when(
        emailChanged: (email) {
          emit(
            state.copyWith(
              emailAddress: EmailAddress(email),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        passwordChanged: (pswrd) {
          emit(
            state.copyWith(
              password: Password(pswrd),
              authFailureOrSuccessOption: none(),
            ),
          );
        },
        registerWithEmailAndPasswordPressed: () async {
          await _performActionOnAuthFacadeWithEmailAndPassword(
            emit,
            _authFacade.registerWithEmailAndPassword,
          );
        },
        signInWithEmailAndPasswordPressed: () async {
          await _performActionOnAuthFacadeWithEmailAndPassword(
            emit,
            _authFacade.signInWithEmailAndPassword,
          );
        },
        signInWithGooglePressed: () async {
          emit(
            state.copyWith(
              isSubmitting: true,
              authFailureOrSuccessOption: none(),
            ),
          );

          final failureOrSuccess = await _authFacade.signInWithGoogle();

          emit(
            state.copyWith(
              isSubmitting: false,
              authFailureOrSuccessOption: some(failureOrSuccess),
            ),
          );
        },
      );
    });
  }
  Future<void> _performActionOnAuthFacadeWithEmailAndPassword(
    Emitter<SignInFormState> emit,
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  ) async {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();

    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
        isSubmitting: true,
        authFailureOrSuccessOption: none(),
      ));
      failureOrSuccess = await forwardedCall(
        emailAddress: state.emailAddress,
        password: state.password,
      );
    }
    emit(
      state.copyWith(
        isSubmitting: false,
        validateMode: AutovalidateMode.always,
        authFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
