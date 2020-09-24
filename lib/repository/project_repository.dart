import 'package:flutter_secure_storage/flutter_secure_storage.dart';

///
/// For Fetching Projects data
///
class ProjectRepository {
  void clearToken() async {
    try {
      final storage = FlutterSecureStorage();
      await storage.delete(key: "token");
    } catch (e) {}
  }
}
