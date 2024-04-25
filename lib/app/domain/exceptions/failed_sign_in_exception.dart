class FailedSignInException implements Exception {
  final String message;

  const FailedSignInException(this.message);

  @override
  String toString() {
    return 'FailedSignInException(message: $message)';
  }
}

class FailedSignUpException implements Exception {
  final String message;

  const FailedSignUpException(this.message);

  @override
  String toString() {
    return 'FailedSignUpException(message: $message)';
  }
}
