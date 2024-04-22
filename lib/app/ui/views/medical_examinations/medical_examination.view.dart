import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/medical_examination.events.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/table_calendar/table_calendar.view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'medical_examination.bloc.dart';

class MedicalExaminationsView extends StatefulWidget {
  const MedicalExaminationsView({super.key});

  @override
  State<MedicalExaminationsView> createState() => _MedicalExaminationsViewState();
}

class _MedicalExaminationsViewState extends State<MedicalExaminationsView> {
  late final MedicalExaminationsBloc _calendarBloc;
  final timeFormatter = DateFormat('HH:mm').format;

  @override
  void initState() {
    super.initState();
    _calendarBloc = MedicalExaminationsBloc();
    _calendarBloc.add(GetExaminationsByDayEvent(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isVertical = size.width > size.height;
    return Scaffold(
      backgroundColor: const Color(0xff1f2733),
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: const Color(0xff1f2733),
        title: const Text('Olá, Daniel'),
        centerTitle: true,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kPadding),
        child: Flex(
          direction: isVertical
            ? Axis.horizontal
            : Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Container(
                padding: const EdgeInsets.all(kPadding),
                decoration: BoxDecoration(
                  color: const Color(0xff2b3c4f),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: Text(
                        'Agenda',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 400, maxWidth: 600),
                      child: TableCalendarComponent(
                        date: DateTime.now(),
                        onDaySelected: (date) => _calendarBloc.add(GetExaminationsByDayEvent(date)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox.square(dimension: kPadding * 2),
            Flexible(
              child: BlocBuilder<MedicalExaminationsBloc, MedicalExaminationsState>(
                bloc: _calendarBloc,
                builder: (context, state) {
                  if (state is FilledMedicalExaminationsState) {
                    return Scrollbar(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            for (final serviceData in state.data)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: ListTile(
                                  key: Key('id_${serviceData.id}'),
                                  onTap: () => context.push(
                                    '/user-info',
                                    extra: serviceData,
                                  ),
                                  minLeadingWidth: 10,
                                  tileColor: const Color(0xff1c2b3a),
                                  leading: Container(
                                    width: 5,
                                    height: 50,
                                    color: Colors.white70,
                                  ),
                                  title: Text('${timeFormatter(serviceData.dateTime)} - ${serviceData.user.name}'),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: kPadding).copyWith(left: 0),
                                  shape: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withAlpha(0x1F),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
