class Subject {
  String subjectName;
  List<int> testScores;

  Subject({required this.subjectName, required this.testScores});

  // Convert a Subject object into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'subjectName': subjectName,
      'testScores': testScores,
    };
  }

  // Convert a JSON object into a Subject object.
  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      subjectName: json['subjectName'],
      testScores: List<int>.from(json['testScores']),
    );
  }
}
