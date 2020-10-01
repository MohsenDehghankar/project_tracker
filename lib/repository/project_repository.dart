import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/model/project/project_detail_result.dart';
import 'package:project_tracker/model/project/project_list_result.dart';
import 'package:project_tracker/model/user/user.dart';
import 'package:project_tracker/model/user/user_result.dart';
import 'package:project_tracker/resource/http_client.dart';
import 'package:project_tracker/resource/local_storage.dart';
import 'package:project_tracker/style/strings.dart';

///
/// For Fetching Projects data
///
class ProjectRepository {
  // clear token
  void clearToken() async {
    try {
      LocalStorage.saveToken(null);
    } catch (e) {}
  }

  Future<UserResult> fetchUserData() async {
    try {
      var token = await LocalStorage.getToken();
      Response response = await HttpClient.fetchUserProfile(token);
      var res = jsonDecode(response.body);
      User user = User(res['name'], "Flutter Developer", res["avatar"]);
      return UserResult()
        ..success = true
        ..user = user;
    } on SocketException catch (e) {
      return UserResult()
        ..error = Strings.networkFail
        ..success = false;
    } on HandshakeException catch (e) {
      return UserResult()
        ..error = Strings.networkFail
        ..success = false;
    } on Exception {
      return UserResult()
        ..error = Strings.unknownError
        ..success = false;
    }
  }

  Future<ProjectListResult> fetchProjects() async {
    try {
      var token = await LocalStorage.getToken();
      Response response = await HttpClient.fetchProjectList(token);
      var res = List.from(jsonDecode(response.body));
      return ProjectListResult.fromJson(res);
    } on SocketException catch (e) {
      return ProjectListResult(false)..error = Strings.networkFailProject;
    } on HandshakeException catch (e) {
      return ProjectListResult(false)..error = Strings.networkFailProject;
    } on Exception catch (e) {
      return ProjectListResult(false)..error = Strings.unknownErrorProject;
    }
  }

  Future<ProjectDetailResult> fetchProjectDetails(String projectId) async {
    try {
      var token = await LocalStorage.getToken();
      Response response = await HttpClient.fetchProjectDetail(projectId, token);
      Project project = Project.fromJson(jsonDecode(response.body), true);
      return ProjectDetailResult()
        ..project = project
        ..error = ""
        ..success = true;
    } on SocketException {
      return ProjectDetailResult()
        ..success = false
        ..error = Strings.networkFail;
    } on HandshakeException {
      return ProjectDetailResult()
        ..success = false
        ..error = Strings.networkFail;
    } on Exception {
      return ProjectDetailResult()
        ..success = false
        ..error = Strings.unknownError;
    }
  }
}
