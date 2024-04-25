import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/entities/user_entity.dart';
import 'package:expermed_test/app/domain/validators/not_empty_validator.dart';
import 'package:expermed_test/app/ui/components/bottom_button.dart';
import 'package:expermed_test/app/ui/components/gradient_textformfield.dart';
import 'package:expermed_test/app/ui/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/medical_examination_form.dart';

class UpdateMedicalExamination extends StatefulWidget {
  final MedicalExaminationEntity medicalExamination;

  const UpdateMedicalExamination(this.medicalExamination, {super.key});

  @override
  State<UpdateMedicalExamination> createState() => _UpdateMedicalExaminationState();
}

class _UpdateMedicalExaminationState extends State<UpdateMedicalExamination> {
  late final entity = widget.medicalExamination;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Atualizar'),
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
