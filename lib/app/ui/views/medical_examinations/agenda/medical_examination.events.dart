import 'package:expermed_test/app/domain/entities/medical_examination.dart';

class MedicalExaminationsEvent {
  const MedicalExaminationsEvent();
}

class GetExaminationsByDayEvent extends MedicalExaminationsEvent {
  final DateTime dateTime;
  const GetExaminationsByDayEvent(this.dateTime);
}

class RemoveExaminationsByDayEvent extends MedicalExaminationsEvent {
  final MedicalExaminationEntity data;
  const RemoveExaminationsByDayEvent(this.data);
}

class AddMedicalExaminationsState extends MedicalExaminationsEvent {
  final MedicalExaminationEntity data;

  const AddMedicalExaminationsState(this.data);
}

class RefreshMedicalExaminationsEvent extends MedicalExaminationsEvent {
  const RefreshMedicalExaminationsEvent();
}


class MedicalExaminationsState {
  const MedicalExaminationsState();
}

class EmptyMedicalExaminationsState extends MedicalExaminationsState {
  const EmptyMedicalExaminationsState();
}

class FilledMedicalExaminationsState extends MedicalExaminationsState {

  final List<MedicalExaminationEntity> data;

  const FilledMedicalExaminationsState(this.data);
}

class FailedMedicalExaminationsState extends MedicalExaminationsState {
  final String message;

  const FailedMedicalExaminationsState(this.message);
}