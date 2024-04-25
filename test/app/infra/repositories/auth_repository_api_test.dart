import 'dart:io' as io;

import 'package:expermed_test/app/infra/repositories/auth_repository_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    io.HttpOverrides.global = null;
  });
  
  test('Must return user data', () async {
    final authRepository = AuthRepositoryApi();
    
    final userInfo = await authRepository.sendSignInRequest('Rasheed.Rodriguez16', 'zKAi7T9AtmzpLq');
  });
}