import 'dart:math';

import 'package:collection/collection.dart';
import 'package:expermed_test/app/domain/entities/service_address.dart';
import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/count_services_day.dart';
import 'package:expermed_test/app/domain/entities/person_entity.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MedicalExaminationRepository)
final class MedicalExaminationRepositoryImpl implements MedicalExaminationRepository {
  @override
  Future<List<MedicalExaminationEntity>> getCalendarServiceEntities(DateTime date) async {
    final dataCount = Random().nextInt(8);

    return List
      .generate(dataCount, (index) => _generateFakeUserEntity(date))
      .sorted((previous, next) => previous.dateTime.compareTo(next.dateTime))
      .toList();
  }

  MedicalExaminationEntity _generateFakeUserEntity(DateTime date) => MedicalExaminationEntity(
    id: faker.randomGenerator.integer(1000).toString(),
    dateTime: date.copyWith(
      hour: faker.randomGenerator.integer(23),
      minute: faker.randomGenerator.integer(60),
    ),
    user: PersonEntity(
      id: faker.randomGenerator.integer(1000),
      name: faker.person.name(),
    ),
    address: ServiceAddressEntity(
      city: faker.address.city(),
      state: faker.address.state(),
      street: faker.address.streetName(),
      number: faker.randomGenerator.integer(10000)
    ),
    assessment: faker.randomGenerator.integer(1000).toString(),
  );

  @override
  Future<List<CountServicesDayEntity>> getMonthCountOfServices(int month) async {
    return [
      for (int i = 0; i < 28; i++)
        if (Random().nextInt(10) > 7)
          CountServicesDayEntity(i, Random().nextInt(5))
    ];
  }

}