import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/medical_examination.events.dart';
import 'package:expermed_test/injector.dart';

class MedicalExaminationsBloc extends Bloc<MedicalExaminationsEvent, MedicalExaminationsState> {
  final calendarRepository = getIt.get<MedicalExaminationRepository>();

  MedicalExaminationsBloc([super.initialState = const EmptyMedicalExaminationsState()]) {
    on(_fetchServicesByDate);
  }

  Future<void> _fetchServicesByDate(GetExaminationsByDayEvent event, Emitter<MedicalExaminationsState> emit) async {
    try {
      final data = await calendarRepository.getCalendarServiceEntities(event.dateTime);
      emit(FilledMedicalExaminationsState(data));
    } catch (e) {
      emit(const FailedMedicalExaminationsState('Unable to retrieve calendar events, please contact support'));
    }
  }
}