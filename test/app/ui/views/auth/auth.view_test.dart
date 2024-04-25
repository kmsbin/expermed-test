import 'dart:io';

import 'package:expermed_test/app/domain/repositories/auth_repository.dart';
import 'package:expermed_test/app/infra/repositories/auth_repository_api.dart';
import 'package:expermed_test/app/infra/repositories/auth_repository_impl.dart';
import 'package:expermed_test/app/router.dart';
import 'package:expermed_test/injector.dart';
import 'package:expermed_test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _email = 'usuarioteste@gmail.com';
const _password = 'Senha1234!@';

class MockHttpOverrides extends HttpOverrides {}

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    SharedPreferences.setMockInitialValues({});
    getIt.allowReassignment = true;
    getIt.registerFactory<AuthRepository>(() => AuthRepositoryImpl());
  });

  testWidgets('Must type valid credentials an go to home', (tester) async {
    await tester.pumpWidget(HomeApp(config: createGoRouter()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('email_field')), _email);
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password_field')), _password);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sign_in_button')));
    await tester.pumpAndSettle();


    expect(find.byKey(const Key('home')), findsOneWidget);
  });

  testWidgets('Must show error modal', (tester) async {
    await tester.pumpWidget(HomeApp(config: createGoRouter()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('email_field')), 'daniel.becker');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password_field')), 'senha1234');
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sign_in_button')));
    await tester.pump(const Duration(seconds: 1));

    expect(find.byKey(const Key('sign_in_error_modal')), findsOneWidget);
  });
}