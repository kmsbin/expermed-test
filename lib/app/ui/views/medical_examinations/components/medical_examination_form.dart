import 'package:expermed_test/app/domain/entities/medical_examination.dart';
import 'package:expermed_test/app/domain/validators/validator.dart';
import 'package:expermed_test/app/ui/components/gradient_container.component.dart';
import 'package:expermed_test/app/ui/components/gradient_input_border.component.dart';
import 'package:expermed_test/app/ui/components/gradient_textformfield.dart';
import 'package:expermed_test/app/ui/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MedicalExaminationForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final MedicalExaminationEntity entity;
  late final dateTextController = TextEditingController(
    text: DateFormat.Hm().format(entity.dateTime),
  );

  static final _defaultInputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static final _defaultStartGradientColor = Colors.white24.withOpacity(0.15);

  MedicalExaminationForm({
    required this.formKey,
    required this.entity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            GradientTextFormField(
              initialValue: entity.user.name,
              validator: const NotEmptyValidator().validate,
              onSaved: (value) => entity.user.name = value ?? '',
              contentStartGradient: _defaultStartGradientColor,
              decoration: _defaultInputDecoration.copyWith(hintText: 'Nome do paciente'),
            ),
            const SizedBox(height: kPadding/2),
            GradientTextFormField(
              contentStartGradient: _defaultStartGradientColor,
              initialValue: entity.address.city,
              decoration: _defaultInputDecoration.copyWith(hintText: 'Cidade'),
              validator: const NotEmptyValidator().validate,
              onSaved: (value) => entity.address.city = value ?? '',
            ),
            const SizedBox(height: kPadding/2),
            GradientTextFormField(
              contentStartGradient: _defaultStartGradientColor,
              initialValue: entity.address.state,
              decoration: _defaultInputDecoration.copyWith(hintText: 'Estado'),
              validator: const NotEmptyValidator().validate,
              onSaved: (value) => entity.address.state = value ?? '',
            ),
            const SizedBox(height: kPadding/2),
            GradientTextFormField(
              contentStartGradient: _defaultStartGradientColor,
              initialValue: (entity.address.number > 0)
                ? entity.address.number.toString()
                : null,
              decoration: _defaultInputDecoration.copyWith(hintText: 'Número'),
              validator: const NotEmptyValidator().validate,
              onSaved: (value) => entity.address.number = int.tryParse(value ?? '') ?? -1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: kPadding/2),
            GradientBorder(
              contentStartGradient: _defaultStartGradientColor,
              child: GestureDetector(
                onTap: () => _setDateTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    readOnly: true,
                    controller: dateTextController,
                    decoration: _defaultInputDecoration.copyWith(hintText: 'Data'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _setDateTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(entity.dateTime),
    );
    if (time == null) return;

    entity.dateTime = entity.dateTime.copyWith(
      hour: time.hour,
      minute: time.minute,
    );
    dateTextController.text = DateFormat.Hm().format(entity.dateTime);
  }
}
