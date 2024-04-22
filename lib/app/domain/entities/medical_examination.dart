import 'package:expermed_test/app/domain/entities/user_entity.dart';

import 'service_address.dart';

class MedicalExaminationEntity {
  final int id;
  final UserEntity user;
  final DateTime dateTime;
  final ServiceAddressEntity address;

  MedicalExaminationEntity({
    required this.id,
    required this.user,
    required this.dateTime,
    required this.address,
  });

}