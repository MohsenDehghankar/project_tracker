import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:project_tracker/model/project/project_phase.dart';

void main() {
  Phase phase;
  test('Creating project Phase from Json', () {
    phase = Phase.fromJson(jsonDecode("""
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
    }
    """));

    expect(phase.name, 'phase 1');
  });

  test('Sorting phase requirements based on priority', () {
    expect(phase.requirements.length, 3);

    expect(
        phase.requirements[0].priority >= phase.requirements[1].priority, true);
  });
}
