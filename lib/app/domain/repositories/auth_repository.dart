abstract interface class AuthRepository {
  Future<void> sendSignInRequest(String email, String password);
}