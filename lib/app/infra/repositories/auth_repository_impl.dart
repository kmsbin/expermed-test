import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';

// @Injectable(as: AuthRepository)
final class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<UserEntity> sendSignInRequest(String email, String password) async {
    if (email != 'usuarioteste@gmail.com' || password != 'Senha1234!@') {
      throw const FailedSignInException('Usuário e senha inválidos');
    }

    return _generateUserEntity();
  }

  UserEntity _generateUserEntity() {
    return UserEntity(
      id: '1',
      name: faker.person.firstName(),
      email: faker.internet.email(),
      pass: faker.internet.password(),
    );
  }

  @override
  Future<void> sendSignUpRequest(String email, String password, String name) async {}
}
