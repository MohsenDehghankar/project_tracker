import 'package:http/http.dart' as http;

/// performing HTTP request
class HttpClient {
  static Future<http.Response> get(String url, Map<String, String> params) {
    return http.get(url, headers: params);
  }

  static Future<http.Response> post(String url, Map<String, String> params) {
    return http.post(url, headers: params);
  }
}

/// Urls for Http request
class Urls {
  static const String authenticateURL =
      'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/login';
  static const String fetchProfileURL =
      'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/profile';
  static const String projectsURL =
      'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/projects';
  static const String projectDetailURL =
      'https://66080cab-1451-4b58-9d0d-cf58942cecfa.mock.pstmn.io/api/v1/project/10';
}
