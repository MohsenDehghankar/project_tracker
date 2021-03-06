import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:project_tracker/model/auth/auth_model.dart';
import 'package:project_tracker/model/auth/auth_result.dart';
import 'package:project_tracker/resource/http_client.dart';
import 'package:project_tracker/resource/local_storage.dart';
import 'package:project_tracker/style/strings.dart';

/// A Class for Fetching Auth related data
class AuthRepository {
  Future<AuthResult> authenticate(AuthModel auth) async {
    String message;
    String token;
    var result;
    try {
      var params = Map<String, String>();
      params["username"] = auth.getUser();
      params["password"] = auth.getPass();
      Response response = await HttpClient.post(Urls.authenticateURL, params);
      // result = jsonDecode(response.body);
      result = jsonDecode("""
{
  "token": "d0274cdf47c1e5f1cb0a68889632bee816fb5cb5"
}
      """);
      token = result['token'];
    } on SocketException catch (e) {
      message = Strings.networkFail;
      return AuthResult(token, AuthResultStatus.failed)..error = message;
    } on HandshakeException {
      message = Strings.networkFail;
      return AuthResult(token, AuthResultStatus.failed)..error = message;
    } on Exception {
      message = Strings.unknownError;
      return AuthResult(token, AuthResultStatus.failed)..error = message;
    } on Error {
      message = Strings.unknownError;
      return AuthResult(token, AuthResultStatus.failed)..error = message;
    }

    _saveToken(token);
    return (token != null)
        ? AuthResult(token, AuthResultStatus.success)
        : AuthResult(token, AuthResultStatus.failed)
      ..error = result["message"];
  }

  // save fetched token
  void _saveToken(String token) async {
    await LocalStorage.saveToken(token);
  }
}

/// Result Statuses
enum AuthResultStatus { success, failed }
