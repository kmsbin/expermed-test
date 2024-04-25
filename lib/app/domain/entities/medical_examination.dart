import 'package:expermed_test/app/domain/entities/person_entity.dart';

import 'service_address.dart';

class MedicalExaminationEntity {
  String id;
  PersonEntity user;
  DateTime dateTime;
  ServiceAddressEntity address;
  String assessment;
  String professionalId;

  MedicalExaminationEntity({
    required this.id,
    required this.user,
    required this.dateTime,
    required this.address,
    required this.assessment,
    this.professionalId = '',
  });

  factory MedicalExaminationEntity.empty() {
    return MedicalExaminationEntity(
      id: '',
      user: PersonEntity(id: -1, name: ''),
      dateTime: DateTime.now(),
      address: ServiceAddressEntity(city: '', state: '', street: '', number: 0),
      assessment: '',
      professionalId: '',
    );
  }

  @override
  String toString() {
    return '''
MedicalExaminationEntity(
  id: $id,
  user: $user,
  dateTime: $dateTime,
  address: $address,
  assessment: $assessment,
  professionalId: $professionalId,,
)
    ''';
  }

}