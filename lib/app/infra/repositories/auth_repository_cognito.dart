import 'package:amazon_cognito_identity_dart_2/cognito.dart';
import 'package:expermed_test/app/domain/exceptions/failed_sign_in_exception.dart';
import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

import '../constants/env_fields.dart';

class AuthRepositoryCognito implements AuthRepository {
  final userPool = CognitoUserPool(
    cognitoUserPoolId,
    cognitoClientId,
  );

  @override
  Future<void> sendSignInRequest(String email, String password) async {
    try {
      final cognitoUser = CognitoUser(email, userPool);

      final authDetails = AuthenticationDetails(
        username: email,
        password: password,
      );
      await cognitoUser.authenticateUser(authDetails);

    } on CognitoClientException catch(e) {
      final message = switch(e.code) {
        'UserNotConfirmedException' => 'Conta não confirmada, entre em contato com o suporte',
        'NotAuthorizedException' => 'Usuário e senha inválidos',
        _ => e.message ?? 'Erro desconhecido',
      };
      throw FailedSignInException(message);
    } catch (e) {
      debugPrint('Erro desconhecido $e');
      rethrow;
    }
  }

  Future<void> sendSignUpRequest(String email, String password, String name) async {
    try {
      final userAttributes = [
        AttributeArg(name: 'name', value: name),
        AttributeArg(name: 'email', value: email),
      ];
      await userPool.signUp(email, password, userAttributes: userAttributes);
    } on CognitoClientException catch(e) {
      debugPrint('error $e code ${e.code}');
    }
  }
}