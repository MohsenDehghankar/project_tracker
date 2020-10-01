import 'package:project_tracker/repository/auth_repository.dart';

///
/// Fetched authentication result
///
class AuthResult {
  String token;
  AuthResultStatus status;
  String error;

  AuthResult(this.token, this.status);
}
