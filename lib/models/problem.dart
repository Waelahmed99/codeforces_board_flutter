enum Verdict {
  ACCEPTED,
  WRONG_ANSWER,
  RUNTIME_ERROR,
  TIME_LIMIT,
  MEMORY_LIMIT,
  NOT_SOLVED,
}

class Problem {
  int id;
  int creationTime;
  int relativeTime;

  // problem related.
  int contestId;
  String index;
  String name;
  String type;
  int points;
  int rating;
  List<String> tags;
  String language;
  Verdict verdict;
  int time;
  int memory;

  // Problem();
  Problem(Map<dynamic, dynamic> data) {
    id = data['id'];
    creationTime = data['creationTimeSeconds'];
    relativeTime = data['relativeTimeSeconds'];

    Map<dynamic, dynamic> problem = data['problem'];
    contestId = problem['contestId'];
    index = problem['index'];
    name = problem['name'];
    type = problem['type'];
    points = problem['points'];
    rating = problem['rating'];

    tags = [];
    (problem['tags'] as List<dynamic>).forEach((value) {
      tags.add(value);
    });
    language = data['programmingLanguage'];

    String ver = data['verdict'];
    switch (ver) {
      case "OK":
        verdict = Verdict.ACCEPTED;
        break;
      case "TIME_LIMIT_EXCEEDED":
        verdict = Verdict.TIME_LIMIT;
        break;
      case "WRONG_ANSWER":
        verdict = Verdict.WRONG_ANSWER;
        break;
      case "MEMORY_LIMIT_EXCEEDED":
        verdict = Verdict.MEMORY_LIMIT;
        break;
      default:
        verdict = Verdict.RUNTIME_ERROR;
    }

    time = data['timeConsumedMillis'];
    memory = data['memoryConsumedBytes'];
  }
}
