import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:scoreboard/models/problem.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;

List<String> problems = [];
Map<String, Verdict> status = {};

void getProblems() async {
  await OpenFile.open('assets/problems.txt');
  String data = await rootBundle.loadString('assets/problems.txt');
  problems = data.split('\n');
  if (problems.isNotEmpty)
    debugPrint('Done loading problems from assets/problems.txt');
  else
    debugPrint('Failed to load assets/problems.txt');
}

void setProblemVerdict(String handle) async {
  // int contestId = int.parse(problem.substring(0, problem.length - 1));
  // String index = problem[problem.length - 1];
  // print('$contestId   $index');
  try {
    http.Response response = await http.get(
        Uri.https('codeforces.com', '/api/user.status', {'handle': handle}));
    Map<dynamic, dynamic> result = json.decode(response.body);
    if (result['status'] != 'OK') return; // todo: handle errors.
    List<dynamic> problems = result['result'];

    status = {};
    problems.forEach((element) {
      Problem problem = Problem(element);
      String problemId = problem.contestId.toString() + problem.index;
      status[problemId] = problem.verdict;
    });
    print(status['677A']);
  } catch (e) {
    print(e);
  }
}
