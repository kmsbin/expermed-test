import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> sendSignInRequest(String email, String password) async {
    if (email != 'daniel.becker@expermed.com' || password != 'senha1234') {
      throw const FailedSignInException('Usuário e senha inválidos');
    }
  }
}
