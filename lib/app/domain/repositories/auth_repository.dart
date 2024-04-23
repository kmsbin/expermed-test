abstract interface class AuthRepository {
  Future<void> sendSignInRequest(String email, String password);

  Future<void> sendSignUpRequest(String email, String password, String name);
}