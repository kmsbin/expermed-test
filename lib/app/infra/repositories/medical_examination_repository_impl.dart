import 'dart:math';

import 'package:expermed_test/app/domain/entities/service_address.dart';
import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/count_services_day.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:faker/faker.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MedicalExaminationRepository)
class MedicalExaminationRepositoryImpl implements MedicalExaminationRepository {
  @override
  Future<List<MedicalExaminationEntity>> getCalendarServiceEntities(DateTime date) async {
    final dataCount = Random().nextInt(8);

    return <MedicalExaminationEntity>[
      for (var i = 0; i <= dataCount; i++)
        _generateFakeUserEntity(date)
    ];
  }

  MedicalExaminationEntity _generateFakeUserEntity(DateTime date) => MedicalExaminationEntity(
      id: faker.randomGenerator.integer(1000),
      dateTime: date,
      user: UserEntity(
        id: faker.randomGenerator.integer(1000),
        name: faker.person.name(),
      ),
      address: ServiceAddressEntity(
        city: faker.address.city(),
        state: faker.address.state(),
        street: faker.address.streetName(),
      ),
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