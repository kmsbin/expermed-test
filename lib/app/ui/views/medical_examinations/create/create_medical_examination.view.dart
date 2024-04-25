import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/validators/not_empty_validator.dart';
import 'package:expermed_test/app/ui/components/bottom_button.dart';
import 'package:expermed_test/app/ui/components/gradient_textformfield.dart';
import 'package:expermed_test/app/ui/constants/colors.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/medical_examination_form.dart';

class CreateMedicalExamination extends StatefulWidget {
  final UserEntity userEntity;
  final DateTime currentDate;

  const CreateMedicalExamination(this.userEntity, this.currentDate, {super.key});

  @override
  State<CreateMedicalExamination> createState() => _CreateMedicalExaminationState();
}

class _CreateMedicalExaminationState extends State<CreateMedicalExamination> {
  late final MedicalExaminationEntity entity;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    entity = MedicalExaminationEntity.empty();
    entity.dateTime = widget.currentDate;
    entity.professionalId = widget.userEntity.id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Cadastro'),
        centerTitle: true,
      ),
      body: MedicalExaminationForm(
        entity: entity,
        formKey: _formKey,
      ),
      bottomNavigationBar: BottomButton(
        onTap: () {
          final state = _formKey.currentState!;
          if (!state.validate()) return;
          state.save();
          context.pop(entity);
        },
        title: const Text('Registrar'),
      ),
    );
  }
}
