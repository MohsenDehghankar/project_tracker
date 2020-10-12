import 'package:project_tracker/repository/auth_repository.dart';

/// Authentication results generated in auth repository.
class AuthResult {
  String token;
  AuthResultStatus status;
  String error;

  AuthResult(this.token, this.status);
}
