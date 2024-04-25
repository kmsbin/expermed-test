import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/agenda/medical_examination.events.dart';
import 'package:expermed_test/injector.dart';

class MedicalExaminationsBloc extends Bloc<MedicalExaminationsEvent, MedicalExaminationsState> {
  final calendarRepository = getIt.get<MedicalExaminationRepository>();

  MedicalExaminationsBloc([super.initialState = const EmptyMedicalExaminationsState()]) {
    on(_fetchServicesByDate);
    on(_deleteExamination);
    on(_addExamination);
    on(_refreshExamination);
  }

  Future<void> _fetchServicesByDate(GetExaminationsByDayEvent event, Emitter<MedicalExaminationsState> emit) async {
    try {
      final data = await calendarRepository.getCalendarServiceEntities(event.dateTime);
      emit(FilledMedicalExaminationsState(data));
    } catch (e) {
      emit(const FailedMedicalExaminationsState('Unable to retrieve calendar events, please contact support'));
    }
  }

  FutureOr<void> _deleteExamination(RemoveExaminationsByDayEvent event, Emitter<MedicalExaminationsState> emit) {
    if (state case FilledMedicalExaminationsState(:final data)) {
      data.remove(event.data);
      emit(FilledMedicalExaminationsState(data));
    }
  }

  FutureOr<void> _addExamination(AddMedicalExaminationsState event, Emitter<MedicalExaminationsState> emit) async {
    if (state case FilledMedicalExaminationsState(:var data)) {
      data.add(event.data);
      data = [...data, event.data]
        .sorted((a, b) => a.dateTime.compareTo(b.dateTime))
        .toList();
      emit(FilledMedicalExaminationsState(data));
      return;
    }
    emit(FilledMedicalExaminationsState([event.data]));
  }

  FutureOr<void> _refreshExamination(RefreshMedicalExaminationsEvent event, Emitter<MedicalExaminationsState> emit) {
    emit(state);
  }
}