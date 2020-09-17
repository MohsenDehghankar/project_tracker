///
/// A class for keeping authentication state.
///
class AuthModel {
  String _username;
  String _password;

  String getPass() {
    return _password;
  }

  String getUser() {
    return _username;
  }

  void setPass(String password) {
    this._password = password;
  }

  void setUser(String username) {
    this._username = username;
  }
}
