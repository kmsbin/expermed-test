class FailedSignInException implements Exception {
  final String message;

  const FailedSignInException(this.message);
}

class FailedSignUpException implements Exception {
  final String message;

  const FailedSignUpException(this.message);
}
