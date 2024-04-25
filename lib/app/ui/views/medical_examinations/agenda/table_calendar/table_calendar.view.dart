import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';

import 'table_calendar.bloc.dart';
import 'table_calendar.events.dart';

class TableCalendarComponent extends StatefulWidget {
  final TableCalendarBloc tableCalendarBloc;
  final DateTime date;
  final void Function(DateTime date) onDaySelected;
  
  const TableCalendarComponent({
    required this.tableCalendarBloc,
    required this.date, 
    required this.onDaySelected,
    super.key,
  });

  @override
  State<TableCalendarComponent> createState() => _TableCalendarComponentState();
}

class _TableCalendarComponentState extends State<TableCalendarComponent> {
  late final TableCalendarBloc tableCalendarBloc;
  static const _locale = 'pt_BR';

  @override
  void initState() {
    super.initState();
    tableCalendarBloc = widget.tableCalendarBloc;
    tableCalendarBloc.add(
      GetMonthCountOfServicesTableMedicalExaminationsEvent(
        currentDate: DateTime.now(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TableCalendarBloc, TableMedicalExaminationsState>(
      bloc: tableCalendarBloc,
      listener: (context, state) {
        if (state is FilledTableMedicalExaminationsState) {
          widget.onDaySelected(state.date);
        }
      },
      builder: (context, state) {
        return TableCalendar(
          firstDay: DateTime.now().subtract(const Duration(days: 365)),
          lastDay: DateTime.now().add(const Duration(days: 365)),
          focusedDay: state.date,
          headerStyle: const HeaderStyle(titleCentered: true, formatButtonVisible: false),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, _) => toBeginningOfSentenceCase(DateFormat.E(_locale).format(date))!,
            weekdayStyle: const TextStyle(color: Colors.white70),
            weekendStyle: const TextStyle(color: Colors.white70)
          ),
          daysOfWeekHeight: 20,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(
              color: Color(0XFF0B1C2B),
              shape: BoxShape.circle,
            ),
            outsideTextStyle: TextStyle(color: Colors.white30),
            weekendTextStyle: TextStyle(color: Color(0xFFBFBFBF)),
          ),
          calendarBuilders: CalendarBuilders(markerBuilder: _markerBuilder),
          locale: _locale,
          onDaySelected: (date, _) => _setDate(date),
          selectedDayPredicate: (day) => isSameDay(day, state.date),
        );
      },
    );
  }
  
  void _setDate(DateTime date) {
    tableCalendarBloc.add(
      GetMonthCountOfServicesTableMedicalExaminationsEvent(
        currentDate: date,
        previousDate: tableCalendarBloc.state.date,
      )
    );
  }

  Widget? _markerBuilder(BuildContext context, DateTime date, _) {
    final state = tableCalendarBloc.state;
    if (state is! FilledTableMedicalExaminationsState) return null;
    final countOfEventsByDay = state.data
      .where((e) => e.day == date.day)
      .map((e) => e.count)
      .sum;
    if (countOfEventsByDay == 0) return null;
    return Positioned(
      top: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(7),
        child: Container(
          height: 7,
          width: 7,
          color: const Color(0xBBDEFFFF),
        ),
      ),
    );
  }
}
