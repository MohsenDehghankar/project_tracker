import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:project_tracker/model/project/project.dart';
import 'package:project_tracker/model/project/project_list_result.dart';

void main() {
  Project project;
  test('Creating project from Json', () {
    project = Project.fromJson(jsonDecode("""
{
  "name": "sourcit",
  "projectId": "project-1",
  "detail": "purchase & sales ERP platform",
  "clientId": "client-322",
  "projectManager": "g.ahmadi",
  "startDate": "2020-07-21T11:21:25.825Z",
  "deadline": "2020-11-05T11:21:25.825Z",
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
      "deadline": "2020-10-29T11:21:25.825Z",
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

    expect(project.name, 'sourcit');
  });

  test('Project fields', () {
    // depends on current date
    expect(project.nearest, DateTime.parse('2020-10-29T11:21:25.825Z'));
    expect(project.phases.length, 3);
    expect(project.nearestPhaseName, 'phase 3');
  });

  ProjectListResult projectList;

  test('Creating project list from Json', () {
    var json = List.from(jsonDecode("""
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
    projectList = ProjectListResult.fromJson(json);

    expect(projectList.projects.length, 4);
  });

  test('Sorting projects list based on nearest deadline', () {
    projectList.sortProjects();

    expect(
        projectList.projects[0].nearest
            .isBefore(projectList.projects[1].nearest),
        true);
    expect(
        projectList.projects[1].nearest
            .isBefore(projectList.projects[2].nearest),
        true);
  });
}
