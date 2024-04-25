import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/repositories/cache_repository.dart';
import 'package:expermed_test/app/domain/usecases/auth_usecase.dart';
import 'package:expermed_test/app/ui/views/auth/sign_in/sign_in.events.dart';
import 'package:expermed_test/injector.dart';


class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final _signInUseCase = AuthUsecase(getIt.get<AuthRepository>(), getIt.get<CacheRepository>());

  SignInBloc([super.initialState = const EmptySignInState()]) {
    on(_sendSignInRequest);
  }

  Future<void> _sendSignInRequest(SendSignInState event, Emitter<SignInState> emit) async {
    try {
      await _signInUseCase.sendSignIn(event.email, event.password);
      emit(const SuccessfulSignInState());
    } on FailedSignInException catch(e) {
      emit(FailedSignInState(e.message));
    }
  }
}