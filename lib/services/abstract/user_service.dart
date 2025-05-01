abstract class UserService {
  Future<bool> registerUser(String login, String password);
  Future<Map<String, String>?> getUser(String login);
  Future<bool> validateUser(String login, String password);
}
