import 'dart:convert';
import 'dart:io';
import 'package:t2208e_dart/models/student.dart';

class StudentService {
  static const String filePath = 'data/Student.json';

  static Future<List<Student>> getAllStudents() async {
    List<dynamic> jsonData = await _readJsonFile();
    return jsonData.map((json) => Student.fromJson(json)).toList();
  }

  static Future<Student?> getStudentById(String id) async {
    List<Student> students = await getAllStudents();
    try {
      return students.firstWhere((student) => student.id == id);
    } catch (e) {
      return null;
    }
  }

  static Future<void> addStudent(Student student) async {
    List<Student> students = await getAllStudents();
    students.add(student);
    await _writeJsonFile(students);
  }

  static Future<void> updateStudent(Student student) async {
    List<Student> students = await getAllStudents();
    int index = students.indexWhere((s) => s.id == student.id);
    if (index != -1) {
      students[index] = student;
      await _writeJsonFile(students);
    }
  }

  static Future<List<Student>> searchStudents(String query) async {
    List<Student> students = await getAllStudents();

    // Normalize the query to lower case for case-insensitive comparison
    String normalizedQuery = query.toLowerCase();

    // Filter students based on whether their name or ID contains the query
    List<Student> filteredStudents = students
        .where((student) =>
            student.name.toLowerCase().contains(normalizedQuery) ||
            student.id.toLowerCase().contains(normalizedQuery))
        .toList();

    return filteredStudents;
  }

  static Future<List<dynamic>> _readJsonFile() async {
    try {
      String content = await File(filePath).readAsString();
      return jsonDecode(content);
    } catch (e) {
      return [];
    }
  }

  static Future<void> _writeJsonFile(List<Student> students) async {
    String jsonString = jsonEncode(students.map((s) => s.toJson()).toList());
    await File(filePath).writeAsString(jsonString);
  }
}
