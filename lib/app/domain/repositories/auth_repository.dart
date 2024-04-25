import 'package:expermed_test/app/domain/entities/user_entity.dart';

abstract interface class AuthRepository {
  Future<UserEntity> sendSignInRequest(String email, String password);

  Future<void> sendSignUpRequest(String email, String password, String name);
}