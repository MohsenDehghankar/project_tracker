import 'package:project_tracker/repository/auth_repository.dart';

class AuthResult {
  String token;
  AuthResultStatus status;
  String error;

  AuthResult(this.token, this.status);
}