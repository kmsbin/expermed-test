import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:expermed_test/app/domain/repositories/medical_examination_repository.dart';
import 'package:expermed_test/injector.dart';
import 'package:flutter/foundation.dart';

import 'table_calendar.events.dart';

class TableCalendarBloc extends Bloc<TableMedicalExaminationsEvent, TableMedicalExaminationsState> {
  final calendarRepository = getIt.get<MedicalExaminationRepository>();

  TableCalendarBloc() : super(EmptyTableMedicalExaminationsState(DateTime.now())) {
    on(_fetchEventsByDate);
  }

  Future<void> _fetchEventsByDate(GetMonthCountOfServicesTableMedicalExaminationsEvent event, Emitter<TableMedicalExaminationsState> emit) async {
    try {
      final state = this.state;
      if (event.previousDate?.month == event.currentDate.month && state is FilledTableMedicalExaminationsState) {
        emit(FilledTableMedicalExaminationsState(event.currentDate, state.data));
        return;
      }
      final monthCounts = await calendarRepository.getMonthCountOfServices(event.currentDate.month);
      emit(FilledTableMedicalExaminationsState(event.currentDate, monthCounts));
    } catch(e) {
      debugPrint('Problemas ao buscar eventos $e');
    }
  }
}