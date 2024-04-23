import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

// @Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> sendSignInRequest(String email, String password) async {
    if (email != 'usuarioteste@gmail.com' || password != 'Senha1234!@') {
      throw const FailedSignInException('Usuário e senha inválidos');
    }
  }

  @override
  Future<void> sendSignUpRequest(String email, String password, String name) async {}
}
