import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/usecases/auth_usecase.dart';
import 'package:expermed_test/app/infra/repositories/shared_preferences_cache_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_usecase_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  final cacheRepository = SharedPreferencesCacheRepository();

  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(cacheRepository.clearCache);

  test('Must invalidate sign in request because email is not valid', () async {
    final authRepository = MockAuthRepository();
    final authUsecase = AuthUsecase(authRepository, cacheRepository);

    expect(
      () async => await authUsecase.sendSignIn('notValidEmail', 'randomPass'),
      throwsA(
        predicate((e) =>
          e is FailedSignInException &&
          e.message == 'E-mail inválido'
        ),
      ),
    );
    expect(await cacheRepository.getUserEntity(), isNull);
  });

  test('Must invalidate sign in request because email is empty', () async {
    final authRepository = MockAuthRepository();
    final authUsecase = AuthUsecase(authRepository, cacheRepository);

    expect(
      () async => await authUsecase.sendSignIn('', 'randomPass'),
      throwsA(
        predicate((e) =>
        e is FailedSignInException &&
            e.message == 'O campo de email precisa ser preenchido'
        ),
      ),
    );
    expect(await cacheRepository.getUserEntity(), isNull);
  });

  test('Must return generic error message because repository throw a unknown error', () async {
    final authRepository = MockAuthRepository();
    when(authRepository.sendSignInRequest(any, any))
      .thenAnswer((realInvocation) => throw Exception('Unknown error'));

    final authUsecase = AuthUsecase(authRepository, cacheRepository);

    expect(
      () async => await authUsecase.sendSignIn('veryValidEmail@gmail.com', 'randomPass'),
      throwsA(
        predicate((e) =>
          e is FailedSignInException &&
          e.message == 'Algo inesperado aconteceu ao realizar o login'
        ),
      ),
    );
    expect(await cacheRepository.getUserEntity(), isNull);
  });

  test('Must rethrow error when repository throws FailedSignInException', () async {
    final authRepository = MockAuthRepository();
    const error = FailedSignInException('rethrowed error');
    when(authRepository.sendSignInRequest(any, any))
        .thenAnswer((realInvocation) => throw error);

    final authUsecase = AuthUsecase(authRepository, cacheRepository);

    expect(
      () async => await authUsecase.sendSignIn('veryValidEmail@gmail.com', 'randomPass'),
      throwsA(
        predicate((e) => e.hashCode == error.hashCode),
      ),
    );
    expect(await cacheRepository.getUserEntity(), isNull);
  });

  test('Must validate request and register data in cache', () async {
    final authRepository = MockAuthRepository();
    const error = FailedSignInException('rethrowed error');
    final userEntity = UserEntity(
      id: '1',
      name: 'Jhon',
      email: 'jhon1234@gmail.com',
      pass: 'jhon1234',
    );
    when(authRepository.sendSignInRequest('jhon1234@gmail.com', 'jhon1234'))
        .thenAnswer((realInvocation) async => userEntity);

    final authUsecase = AuthUsecase(authRepository, cacheRepository);

    await authUsecase.sendSignIn('jhon1234@gmail.com', 'jhon1234');

    final cachedUserEntity = await cacheRepository.getUserEntity();
    expect(cachedUserEntity?.id, equals(userEntity.id));
    expect(cachedUserEntity?.name, equals(userEntity.name));
    expect(cachedUserEntity?.email, equals(userEntity.email));
    expect(cachedUserEntity?.pass, equals(userEntity.pass));
  });
}