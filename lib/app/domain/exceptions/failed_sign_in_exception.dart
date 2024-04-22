class FailedSignInException implements Exception {
  final String message;

  const FailedSignInException(this.message);
}
