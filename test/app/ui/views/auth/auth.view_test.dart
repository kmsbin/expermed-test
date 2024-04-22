import 'package:expermed_test/app/router.dart';
import 'package:expermed_test/injector.dart';
import 'package:expermed_test/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
  });

  testWidgets('Must type valid credentials an go to home', (tester) async {
    await tester.pumpWidget(HomeApp(config: createGoRouter()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('email_field')), 'daniel.becker@expermed.com');
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key('password_field')), 'senha1234');
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