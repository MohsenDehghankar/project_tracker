import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Storage for Auth Token
///
class LocalStorage {
  static Future<String> getToken() async {
    if (kIsWeb) {
      // running on web
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        String token = sharedPreferences.getString("token");
        return token;
      } catch (e) {
        debugPrint("Can't get token from shared preferences!");
        return null;
      }
    } else {
      try {
        final storage = FlutterSecureStorage();
        String token = await storage.read(key: 'token');
        return token;
      } catch (e) {
        debugPrint("Can't Get Token");
        return null;
      }
    }
  }

  static Future<void> saveToken(String token) async {
    if (kIsWeb) {
      // running on web
      try {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        await sharedPreferences.setString("token", token);
      } catch (e) {
        debugPrint("Can't save token from shared preferences!");
      }
    } else {
      try {
        final storage = FlutterSecureStorage();
        await storage.write(key: "token", value: token);
      } catch (e) {
        debugPrint("Can't Save Token");
      }
    }
  }
}
