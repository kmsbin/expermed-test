import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/domain/repositories/cache_repository.dart';
import 'package:expermed_test/app/domain/validators/password_validator.dart';
import 'package:expermed_test/app/domain/validators/validator.dart';

class AuthUsecase {
  final AuthRepository _repository;
  final CacheRepository _cacheRepository;

  const AuthUsecase(this._repository, this._cacheRepository);

  Future<void> sendSignIn(String email, String password) async {
    try {
      if (const EmailValidator().validate(email) case final String error) {
        throw FailedSignInException(error);
      }
      final userEntity = await _repository.sendSignInRequest(email, password);

      await _cacheRepository.saveUserEntity(userEntity);
    } on FailedSignInException {
      rethrow;
    } catch (e) {
      throw const FailedSignInException('Algo inesperado aconteceu ao realizar o login');
    }
  }

  Future<void> sendSignUp(String email, String password, String name) async {
    try {
      if (const EmailValidator().validate(email) case final String error) {
        throw FailedSignUpException(error);
      }

      if (const PasswordValidator().validate(password) case final String error) {
        throw FailedSignUpException(error);
      }

      if (const NotEmptyValidator().validate(name) case final String error) {
        throw FailedSignUpException(error);
      }

      await _repository.sendSignUpRequest(email, password, name);
    } on FailedSignUpException {
      rethrow;
    } catch (e) {
      throw const FailedSignUpException('Algo inesperado aconteceu ao realizar o cadastro');
    }
  }
}
