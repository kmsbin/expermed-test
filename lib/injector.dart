import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/infra/repositories/auth_repository_cognito.dart';
import 'package:expermed_test/app/infra/repositories/auth_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app/infra/constants/env_fields.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
  // if (cognitoUserPoolId.isEmpty) {
  //   getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  // } else {
  //   getIt.registerFactory<AuthRepository>(() => AuthRepositoryCognito());
  // }
}