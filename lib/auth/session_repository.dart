abstract class SessionRepository {
  Future<bool> isLoggedIn();

  Future<String?> getAccessToken();

  Future<void> saveAccessToken(String accessToken);

  Future<void> removeAccessToken();
}
