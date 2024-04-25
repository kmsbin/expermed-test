import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/person_entity.dart';
import 'package:expermed_test/app/domain/entities/service_address.dart';
import 'package:json_annotation/json_annotation.dart';

part 'medical_examination_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MedicalExaminationModel {
  final String id;
  final int professionalId;
  final DateTime scheduleTo;
  final String assessment;
  final String victimName;
  final String city;
  final String state;
  final String street;
  final int number;

  const MedicalExaminationModel({
    required this.id,
    required this.professionalId,
    required this.scheduleTo,
    required this.assessment,
    required this.victimName,
    required this.city,
    required this.state,
    required this.street,
    required this.number,
  });

  factory MedicalExaminationModel.fromJson(Map<String, dynamic> jsonMap) =>
      _$MedicalExaminationModelFromJson(jsonMap);

  Map<String, dynamic> toJson() => _$MedicalExaminationModelToJson(this);

  MedicalExaminationEntity toEntity() {
    return MedicalExaminationEntity(
      id: id,
      user: PersonEntity(id: -1, name: victimName),
      address: ServiceAddressEntity(
        city: city,
        state: state,
        street: street,
        number: number,
      ),
      dateTime: scheduleTo,
      assessment: assessment,
    );
  }
}
