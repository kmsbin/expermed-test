import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/ui/blocs/user_cache/user_cache.bloc.dart';
import 'package:expermed_test/app/ui/blocs/user_cache/user_cache.events.dart';
import 'package:expermed_test/app/ui/components/bottom_button.dart';
import 'package:expermed_test/app/ui/constants/colors.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:expermed_test/app/ui/views/medical_examinations/agenda/table_calendar/table_calendar.bloc.dart';
import 'package:expermed_test/injector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'medical_examination.bloc.dart';
import 'medical_examination.events.dart';
import 'table_calendar/table_calendar.view.dart';

class MedicalExaminationsView extends StatefulWidget {
  const MedicalExaminationsView({super.key});

  @override
  State<MedicalExaminationsView> createState() => _MedicalExaminationsViewState();
}

class _MedicalExaminationsViewState extends State<MedicalExaminationsView> {
  final _medicalExamBloc = MedicalExaminationsBloc();
  final _calendarBloc = TableCalendarBloc();
  final _userCacheBloc = getIt.get<UserCacheBloc>();
  final timeFormatter = DateFormat('HH:mm').format;
  bool showWarningDeletion = true;

  @override
  void initState() {
    super.initState();
    _medicalExamBloc.add(GetExaminationsByDayEvent(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isVertical = size.width > size.height;
    return Scaffold(
      backgroundColor: appBackgroundColor,
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        backgroundColor: appBackgroundColor,
        title: BlocBuilder<UserCacheBloc, UserCacheState>(
          bloc: _userCacheBloc,
          builder: (context, state) {
            return switch(state) {
              FilledUserCacheState(userEntity: final userEntity) => Text('Olá, ${userEntity.name}'),
              LoadingUserCacheState() => const CircularProgressIndicator(),
              _ => const Text('Olá')
            };
          }
        ),
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
                        tableCalendarBloc: _calendarBloc,
                        date: DateTime.now(),
                        onDaySelected: (date) => _medicalExamBloc.add(GetExaminationsByDayEvent(date)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox.square(dimension: kPadding * 2),
            Flexible(
              child: BlocBuilder<MedicalExaminationsBloc, MedicalExaminationsState>(
                bloc: _medicalExamBloc,
                builder: (context, state) {
                  if (state is FilledMedicalExaminationsState) {
                    return ListView(
                      padding: const EdgeInsets.only(bottom: kPadding),
                      children: [
                        for (final medicalExamination in state.data)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: ListTile(
                              key: Key('id_${medicalExamination.id}'),
                              onTap: () async {
                                await context.push(
                                  '/user-info',
                                  extra: medicalExamination,
                                );
                                _medicalExamBloc.add(const RefreshMedicalExaminationsEvent());
                              },
                              trailing: IconButton(
                                onPressed: () => _deleteExamination(context, medicalExamination) ,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                              minLeadingWidth: 10,
                              tileColor: const Color(0xff1c2b3a),
                              leading: Container(
                                width: 5,
                                height: 50,
                                color: Colors.white70,
                              ),
                              title: Text('${timeFormatter(medicalExamination.dateTime)} - ${medicalExamination.user.name}'),
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
                    );
                  }
                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<UserCacheBloc, UserCacheState>(
        bloc: _userCacheBloc,
        builder: (context, state) {
          return BottomButton(
            onTap: state is FilledUserCacheState
              ? () => _registerExamination(state.userEntity)
              : null,
            title: const Text('Cadastrar'),
          );
        }
      ),
    );
  }

  Future<void> _registerExamination(UserEntity userEntity) async {
    final result = await context.push<MedicalExaminationEntity>(
      '/create-medical-examination',
      extra: (userEntity, _calendarBloc.state.date),
    );
    if (result == null) return;
    print(result);
    _medicalExamBloc.add(AddMedicalExaminationsState(result));
  }

  Future<bool> _showWarningToDeleteExamination(BuildContext context) async {
    if (!showWarningDeletion) return true;

    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseje mesmo deletar?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ao deletar o item você não poderá reverter.'),
            StatefulBuilder(
              builder: (context, setState) {
                return CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  value: !showWarningDeletion,
                  onChanged: (value) => setState(() => showWarningDeletion = !showWarningDeletion),
                  title: const Text('Não mostrar mais esse aviso'),
                );
              }
            )
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Sim '),
          ),
        ],
      ),
    ) ?? false;
  }

  Future<void> _deleteExamination(BuildContext context, MedicalExaminationEntity medicalExamination) async {
    if (await _showWarningToDeleteExamination(context)) {
      _medicalExamBloc.add(RemoveExaminationsByDayEvent(medicalExamination));
    }
  }
}
