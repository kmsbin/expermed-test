import 'validator.dart';

class PasswordValidator extends Validator {
  const PasswordValidator();

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) return 'O campo de senha não pode ficar vazio';
    if (value.length < 6) return 'A senha deve ter ao menos 6 caracteres';
    if (!value.contains(RegExp(r'\d+'))) return 'A senha deve ter ao menos 1 número';
    if (!value.contains(RegExp(r'[`!@#$%^&*()_\-+=\[\]{};:\\|,.<>/?~ ]'))) return 'A senha deve conter ao menos 1 caracter especial';
    return null;
  }
}