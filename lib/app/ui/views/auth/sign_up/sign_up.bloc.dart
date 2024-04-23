import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/usecases/auth_usecase.dart';
import 'package:expermed_test/injector.dart';

import 'sign_up.events.dart';


class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final _signUpUseCase = AuthUsecase(getIt.get<AuthRepository>());

  SignUpBloc([super.initialState = const EmptySignUpState()]) {
    on(_sendSignUpRequest);
  }

  Future<void> _sendSignUpRequest(SendSignUpState event, Emitter<SignUpState> emit) async {
    try {
      await _signUpUseCase.sendSignUp(event.email, event.password, event.name);
      emit(const SuccessfulSignUpState());
    } on FailedSignUpException catch(e) {
      emit(FailedSignUpState(e.message));
    }
  }
}