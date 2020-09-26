import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:project_tracker/model/project_list_result.dart';
import 'package:project_tracker/model/user.dart';
import 'package:project_tracker/model/user_result.dart';
import 'package:project_tracker/resource/http_client.dart';

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

  Future<UserResult> fetchUserData() async {
    try {
      final storage = FlutterSecureStorage();
      var token = await storage.read(key: "token");
      Response response = await HttpClient.fetchUserProfile(token);
      var res = jsonDecode(response.body);
      User user = User(res['name'], "Flutter Developer", res["avatar"]);
      return UserResult()
        ..success = true
        ..user = user;
    } on SocketException catch (e) {
      return UserResult()
        ..error = "Network Problem"
        ..success = false;
    } on HandshakeException catch (e) {
      return UserResult()
        ..error = "Network Problem"
        ..success = false;
    } on Exception {
      return UserResult()
        ..error = "Unknown error!"
        ..success = false;
    }
  }

  Future<ProjectListResult> fetchProjects() async {
    try {
      final storage = FlutterSecureStorage();
      var token = await storage.read(key: "token");
      Response response = await HttpClient.fetchProjectList(token);
      var res = List.from(jsonDecode(response.body));
      return ProjectListResult.fromJson(res);
    } on SocketException catch (e) {
      return ProjectListResult(false)
        ..error = "Network Problem while fetching projects!";
    } on HandshakeException catch (e) {
      return ProjectListResult(false)
        ..error = "Network Problem while fetching projects!";
    } on Exception catch (e) {
      return ProjectListResult(false)
        ..error = "Unknown error while fetching projects list.";
    }
  }
}