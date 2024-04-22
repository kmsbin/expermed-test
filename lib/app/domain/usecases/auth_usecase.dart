import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/validators/email_validator.dart';

class AuthUsecase {
  final AuthRepository _repository;

  const AuthUsecase(this._repository);

  Future<void> sendSignIn(String email, String password) async {
    try {
      if (const EmailValidator().validate(email) case final String error) {
        throw FailedSignInException(error);
      }
      await _repository.sendSignInRequest(email, password);
    } on FailedSignInException {
      rethrow;
    } catch (e) {
      throw const FailedSignInException('Algo inesperado aconteceu ao realizar o login');
    }
  }
}
