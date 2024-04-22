import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/usecases/auth_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  test('Must invalidate sign in request because email is not valid', () async {
    final authRepository = MockAuthRepository();
    final authUsecase = AuthUsecase(authRepository);

    expect(
      () async => await authUsecase.sendSignIn('notValidEmail', 'randomPass'),
      throwsA(
        predicate((e) =>
          e is FailedSignInException &&
          e.message == 'E-mail inválido'
        ),
      ),
    );
  });

  test('Must invalidate sign in request because email is empty', () async {
    final authRepository = MockAuthRepository();
    final authUsecase = AuthUsecase(authRepository);

    expect(
      () async => await authUsecase.sendSignIn('', 'randomPass'),
      throwsA(
        predicate((e) =>
        e is FailedSignInException &&
            e.message == 'O campo de email precisa ser preenchido'
        ),
      ),
    );
  });

  test('Must return generic error message because repository throw a unknown error', () async {
    final authRepository = MockAuthRepository();
    when(authRepository.sendSignInRequest(any, any))
      .thenAnswer((realInvocation) => throw Exception('Unknown error'));

    final authUsecase = AuthUsecase(authRepository);

    expect(
      () async => await authUsecase.sendSignIn('veryValidEmail@gmail.com', 'randomPass'),
      throwsA(
        predicate((e) =>
          e is FailedSignInException &&
          e.message == 'Algo inesperado aconteceu ao realizar o login'
        ),
      ),
    );
  });

  test('Must rethrow error when repository throws FailedSignInException', () async {
    final authRepository = MockAuthRepository();
    const error = FailedSignInException('rethrowed error');
    when(authRepository.sendSignInRequest(any, any))
        .thenAnswer((realInvocation) => throw error);

    final authUsecase = AuthUsecase(authRepository);

    expect(
          () async => await authUsecase.sendSignIn('veryValidEmail@gmail.com', 'randomPass'),
      throwsA(
        predicate((e) => e.hashCode == error.hashCode),
      ),
    );
  });
}