import 'validator.dart';

class NotEmptyValidator extends Validator {
  const NotEmptyValidator();

  @override
  String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'O campo deve ser preenchido';
    }
    return null;
  }
}