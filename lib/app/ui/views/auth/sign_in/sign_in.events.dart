class SignInEvent {
  const SignInEvent();
}

class SignInState {
  const SignInState();
}

class EmptySignInState extends SignInState {
  const EmptySignInState();
}

class SuccessfulSignInState extends SignInState {
  const SuccessfulSignInState();
}

class FailedSignInState extends SignInState {
  final String message;

  const FailedSignInState(this.message);
}

class SendSignInState extends SignInEvent {
  final String email;
  final String password;

  const SendSignInState(
    this.email,
    this.password,
  );
}