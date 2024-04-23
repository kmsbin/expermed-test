class SignUpEvent {
  const SignUpEvent();
}

class SignUpState {
  const SignUpState();
}

class EmptySignUpState extends SignUpState {
  const EmptySignUpState();
}

class SuccessfulSignUpState extends SignUpState {
  const SuccessfulSignUpState();
}

class FailedSignUpState extends SignUpState {
  final String message;

  const FailedSignUpState(this.message);
}

class SendSignUpState extends SignUpEvent {
  final String email;
  final String password;
  final String name;

  const SendSignUpState({
    required this.email,
    required this.password,
    required this.name,
  });
}