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
      // var res = jsonDecode(response.body);
      var res = jsonDecode("""
{
  "name": "gholam reza ahmadi",
  "username": "g.ahmadi",
  "avatar": "https://picsum.photos/300/300"
}
      """);
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
    } on Error {
      return UserResult()
        ..error = Strings.unknownError
        ..success = false;
    }
  }

  Future<ProjectListResult> fetchProjects() async {
    try {
      var token = await LocalStorage.getToken();
      Response response = await HttpClient.fetchProjectList(token);
      // var res = List.from(jsonDecode(response.body));
      var res = List.from(jsonDecode("""
[
  {
    "name": "sourcit",
    "projectId": "project-1",
    "detail": "purchase & sales ERP platform",
    "clientId": "client-322",
    "projectManager": "g.ahmadi",
    "startDate": "2020-07-21T11:21:25.825Z",
    "deadline": "2020-10-21T11:21:25.825Z",
    "phases": [
      {
        "name": "phase 1",
        "deadline": "2020-07-24T11:21:25.825Z"
      },
      {
        "name": "phase 2",
        "deadline": "2020-10-28T11:21:25.825Z"
      },
      {
        "name": "phase 3",
        "deadline": "2020-11-12T11:21:25.825Z"
      }
    ]
  },
  {
    "name": "erp",
    "projectId": "project-2",
    "detail": "purchase & sales ERP platform",
    "clientId": "client-312",
    "projectManager": "g.ahmadi",
    "startDate": "2020-07-21T11:21:25.825Z",
    "deadline": "2020-10-29T11:21:25.825Z",
    "phases": [
      {
        "name": "phase 1",
        "deadline": "2020-10-20T11:21:25.825Z"
      },
      {
        "name": "phase 2",
        "deadline": "2020-10-28T11:21:25.825Z"
      }
    ]
  },
  {
    "name": "barchasber",
    "projectId": "project-3",
    "detail": "purchase & sales ERP platform",
    "clientId": "client-322",
    "projectManager": "g.ahmadi",
    "startDate": "2020-07-21T11:21:25.825Z",
    "deadline": "2020-11-21T11:21:25.825Z",
    "phases": [
      {
        "name": "phase 1",
        "deadline": "2020-07-22T11:21:25.825Z"
      },
      {
        "name": "phase 2",
        "deadline": "2020-10-28T11:21:25.825Z"
      },
      {
        "name": "phase 3",
        "deadline": "2020-11-12T11:21:25.825Z"
      }
    ]
  },
  {
    "name": "gholoomi",
    "projectId": "project-4",
    "detail": "purchase & sales ERP platform",
    "clientId": "client-322",
    "projectManager": "g.ahmadi",
    "startDate": "2020-07-21T11:21:25.825Z",
    "deadline": "2020-11-21T11:21:25.825Z",
    "phases": [
      {
        "name": "phase 1",
        "deadline": "2020-07-21T11:21:25.825Z"
      }
    ]
  }
]
      """));
      return ProjectListResult.fromJson(res);
    } on SocketException catch (e) {
      return ProjectListResult(false)..error = Strings.networkFailProject;
    } on HandshakeException catch (e) {
      return ProjectListResult(false)..error = Strings.networkFailProject;
    } on Exception catch (e) {
      return ProjectListResult(false)..error = Strings.unknownErrorProject;
    } on Error {
      return ProjectListResult(false)..error = Strings.unknownErrorProject;
    }
  }

  Future<ProjectDetailResult> fetchProjectDetails(String projectId) async {
    try {
      var token = await LocalStorage.getToken();
      Response response = await HttpClient.fetchProjectDetail(projectId, token);
      // Project project = Project.fromJson(jsonDecode(response.body), true);
      Project project = Project.fromJson(jsonDecode("""
{
  "name": "sourcit",
  "projectId": "project-1",
  "detail": "purchase & sales ERP platform",
  "clientId": "client-322",
  "projectManager": "g.ahmadi",
  "startDate": "2020-07-21T11:21:25.825Z",
  "deadline": "2020-10-21T11:21:25.825Z",
  "phases": [
    {
      "name": "phase 1",
      "description": "design UI/UX",
      "deadline": "2020-09-24T11:21:25.825Z",
      "requirements": [
        {
          "title": "req 1",
          "description": "req 1 desc",
          "priority": 1
        },
        {
          "title": "req 2",
          "priority": 0
        },
        {
          "title": "req 3",
          "description": "req 3 desc",
          "priority": 3
        }
      ]
    },
    {
      "name": "phase 2",
      "description": "implementation",
      "deadline": "2020-09-28T11:21:25.825Z",
      "requirements": [
        {
          "title": "req 1",
          "description": "req 1 desc",
          "priority": 1
        },
        {
          "title": "req 3",
          "description": "req 3 desc",
          "priority": 3
        }
      ]
    },
    {
      "name": "phase 3",
      "description": "debug",
      "deadline": "2020-10-12T11:21:25.825Z",
      "requirements": [
        {
          "title": "req 1",
          "description": "req 1 desc",
          "priority": 1
        },
        {
          "title": "req 2",
          "priority": 0
        },
        {
          "title": "req 3",
          "description": "req 3 desc",
          "priority": 3
        }
      ]
    }
  ]
}
      """), true);
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
    } on Error {
      return ProjectDetailResult()
        ..success = false
        ..error = Strings.unknownError;
    }
  }
}
