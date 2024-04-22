
import 'package:expermed_test/app/domain/entities/count_services_day.dart';

class TableMedicalExaminationsEvent {
  const TableMedicalExaminationsEvent();
}

class GetMonthCountOfServicesTableMedicalExaminationsEvent extends TableMedicalExaminationsEvent {
  final DateTime currentDate;
  final DateTime? previousDate;

  const GetMonthCountOfServicesTableMedicalExaminationsEvent({
    required this.currentDate,
    this.previousDate,
  });
}

class TableMedicalExaminationsState {
  final DateTime date;
  const TableMedicalExaminationsState(this.date);
}

class EmptyTableMedicalExaminationsState extends TableMedicalExaminationsState {
  const EmptyTableMedicalExaminationsState(super.date);
}

class FilledTableMedicalExaminationsState extends TableMedicalExaminationsState {
  final List<CountServicesDayEntity> data;

  const FilledTableMedicalExaminationsState(super.date, this.data);
}
