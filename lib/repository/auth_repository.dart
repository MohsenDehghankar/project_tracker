import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:project_tracker/model/auth/auth_model.dart';
import 'package:project_tracker/model/auth/auth_result.dart';
import 'package:project_tracker/resource/http_client.dart';
import 'package:project_tracker/resource/local_storage.dart';
import 'package:project_tracker/style/strings.dart';

///
/// A Class for Fetching Auth related data
///
class AuthRepository {
  Future<AuthResult> authenticate(AuthModel auth) async {
    String message;
    String token;
    var result;
    try {
      Response response = await HttpClient.authenticate(auth);
      result = jsonDecode(response.body);
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
    }

    _saveToken(token);
    return (token != null)
        ? AuthResult(token, AuthResultStatus.success)
        : AuthResult(token, AuthResultStatus.failed)
      ..error = result["message"];
  }

  void _saveToken(String token) async {
    await LocalStorage.saveToken(token);
  }
}

enum AuthResultStatus { success, failed }
