import 'subject.dart';

class Student {
  String id;
  String name;
  List<Subject> subjects;

  Student({required this.id, required this.name, required this.subjects});

  // Convert a Student object into a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'subjects': subjects.map((subject) => subject.toJson()).toList(),
    };
  }

  // Convert a JSON object into a Student object.
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
    );
  }
}
