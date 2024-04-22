
import 'validator.dart';

class EmailValidator extends Validator {
  const EmailValidator();

  @override
  String? validate(String? email) {
    if (email == null || email.isEmpty) return 'O campo de email precisa ser preenchido';
    final matcher = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+(\.[a-zA-Z]+)?$');
    if (matcher.hasMatch(email)) return null;
    return 'E-mail inválido';
  }
}