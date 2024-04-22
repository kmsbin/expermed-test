import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/count_services_day.dart';

abstract interface class MedicalExaminationRepository {
  Future<List<MedicalExaminationEntity>> getCalendarServiceEntities(DateTime date);

  Future<List<CountServicesDayEntity>> getMonthCountOfServices(int month);
}