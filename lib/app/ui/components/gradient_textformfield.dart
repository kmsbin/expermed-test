import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'gradient_input_border.component.dart';

class GradientTextFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final Color contentStartGradient;
  final InputDecoration? decoration;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const GradientTextFormField({
    required this.contentStartGradient,
    this.initialValue,
    this.validator,
    this.decoration,
    this.onSaved,
    this.inputFormatters,
    this.keyboardType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: initialValue,
      validator: validator,
      onSaved: onSaved,
      builder: (state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GradientBorder(
              contentStartGradient: contentStartGradient,
              child: TextFormField(
                initialValue: initialValue,
                onChanged: state.didChange,
                decoration: decoration,
                inputFormatters: inputFormatters,
                keyboardType: keyboardType,
              ),
            ),
            if (state.hasError)
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 4),
                  child: Text(
                    state.errorText!,
                    style: Theme
                      .of(context).textTheme.bodySmall!
                      .copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              )
          ],
        );
      },
    );
  }
}
