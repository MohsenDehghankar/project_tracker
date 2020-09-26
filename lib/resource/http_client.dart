import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project_tracker/model/auth_model.dart';
import 'package:project_tracker/model/auth_result.dart';

///
/// API Calls
///
class HttpClient {
  // Authenticate By API call
  static Future<http.Response> authenticate(AuthModel auth) {
    Map<String, String> params = Map();
    params["username"] = auth.getUser();
    params["password"] = auth.getPass();
    return http.post(
        'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/login',
        body: jsonEncode(params));
  }

  static Future<http.Response> fetchUserProfile(String token) {
    Map<String, String> headers = Map();
    headers['Authorization'] = token;
    return http.get(
        'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/profile',
        headers: headers);
  }

  static Future<http.Response> fetchProjectList(String token) {
    Map<String, String> headers = Map();
    headers['Authorization'] = token;
    return http.get(
        'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/projects',
        headers: headers);
  }
}
