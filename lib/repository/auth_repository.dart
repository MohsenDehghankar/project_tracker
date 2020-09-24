import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:project_tracker/model/auth_model.dart';
import 'package:project_tracker/model/auth_result.dart';
import 'package:project_tracker/resource/http_client.dart';

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
      debugPrint("response ==> ${response.body}");
      result = jsonDecode(response.body);
      token = result['token'];
    } on Exception catch (e) {
      message = e.toString();
      return AuthResult(token, AuthResultStatus.failed)..error = message;
    }

    _saveToken(token);
    return (token != null)
        ? AuthResult(token, AuthResultStatus.success)
        : AuthResult(token, AuthResultStatus.failed)
      ..error = result["message"];
  }

  void _saveToken(String token) async {
    try {
      final storage = new FlutterSecureStorage();
      await storage.write(key: 'token', value: token);
    } catch (e) {}
  }
}

enum AuthResultStatus { success, failed }
