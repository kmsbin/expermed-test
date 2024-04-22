import 'dart:math';

import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/service_address.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:expermed_test/app/router.dart';
import 'package:expermed_test/injector.dart';
import 'package:expermed_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'medical_examination.view_test.mocks.dart';

@GenerateMocks([MedicalExaminationRepository])
void main() {

  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    configureDependencies();
    getIt.allowReassignment = true;
  });

  testWidgets('Must list all calendar events', (tester) async {
    final repository = MockMedicalExaminationRepository();

    when(repository.getCalendarServiceEntities(any))
      .thenAnswer((_) async => [
        _generateMedicalExamination(2),
        _generateMedicalExamination(3),
        _generateMedicalExamination(9),
      ]);
    when(repository.getMonthCountOfServices(any))
      .thenAnswer((realInvocation) async => []);

    getIt.registerFactory<MedicalExaminationRepository>(() => repository);
    await tester.pumpWidget(
      HomeApp(
        config: createGoRouter(initialLocation: '/medical-examinations'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('id_2')), findsOneWidget);
    expect(find.byKey(const Key('id_3')), findsOneWidget);
    expect(find.byKey(const Key('id_9')), findsOneWidget);
  });

  testWidgets('Must redirect to user info page', (tester) async {
    final repository = MockMedicalExaminationRepository();

    when(repository.getCalendarServiceEntities(any))
        .thenAnswer((_) async => [
      _generateMedicalExamination(50),
    ]);
    when(repository.getMonthCountOfServices(any))
        .thenAnswer((realInvocation) async => []);

    getIt.registerFactory<MedicalExaminationRepository>(() => repository);
    await tester.pumpWidget(
      HomeApp(
        config: createGoRouter(initialLocation: '/medical-examinations'),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('id_50')));
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('user_info_50')), findsOneWidget);
  });
}

MedicalExaminationEntity _generateMedicalExamination(int id) {
  return MedicalExaminationEntity(
    id: id,
    user: UserEntity(
      id: id,
      name: 'user',
    ),
    dateTime: DateTime.now(),
    address: const ServiceAddressEntity(city: '', state: '', street: ''),
  );
}