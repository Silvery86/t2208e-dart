import 'dart:io';
import 'package:t2208e_dart/models/student.dart';
import 'package:t2208e_dart/services/student_service.dart';
import 'package:t2208e_dart/models/subject.dart';

void main() async {
  await runStudentManagement();
}

Future<void> runStudentManagement() async {
  while (true) {
    print("\nStudent Management Program");
    print("1. View All Students");
    print("2. Add New Student");
    print("3. Edit Student");
    print("4. Search Student By Name And Id");
    print("5. Exit");
    stdout.write("Choose an option: ");
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        await viewAllStudents();
        break;
      case '2':
        await addNewStudent();
        break;
      case '3':
        await editStudent();
        break;
      case '4':
        await searchStudent();
        break;
      case '5':
        print("Exiting the program...");
        return;
      default:
        print("Invalid option. Please try again.");
    }
  }
}

Future<void> viewAllStudents() async {
  List<Student> students = await StudentService.getAllStudents();
  if (students.isEmpty) {
    print("No students found.");
  } else {
    print("\nList of All Students:");
    for (var student in students) {
      print("ID: ${student.id}, Name: ${student.name}");
      for (var subject in student.subjects) {
        print("  Subject: ${subject.subjectName}, Scores: ${subject.testScores.join(', ')}");
      }
    }
  }
}

Future<void> addNewStudent() async {
  stdout.write("Enter Student ID: ");
  String id = stdin.readLineSync()!;
  stdout.write("Enter Student Name: ");
  String name = stdin.readLineSync()!;

  List<Subject> subjects = [];
  while (true) {
    stdout.write("Enter Subject Name: ");
    String subjectName = stdin.readLineSync()!;
    if (subjectName.toLowerCase() == 'done') break;

    stdout.write("Enter Test Scores: ");
    List<int> scores = stdin.readLineSync()!.split(',').map((s) => int.parse(s.trim())).toList();

    subjects.add(Subject(subjectName: subjectName, testScores: scores));
  }

  Student newStudent = Student(id: id, name: name, subjects: subjects);
  await StudentService.addStudent(newStudent);
  print("Student added successfully.");
}

Future<void> editStudent() async {
  stdout.write("Enter Student ID to edit: ");
  String id = stdin.readLineSync()!;
  Student? student = await StudentService.getStudentById(id);

  if (student == null) {
    print("Student not found.");
    return;
  }

  stdout.write("Enter New Name (or press Enter to keep '${student.name}'): ");
  String? newName = stdin.readLineSync();
  if (newName != null && newName.isNotEmpty) {
    student.name = newName;
  }

  List<Subject> subjects = [];
  for (var subject in student.subjects) {
    stdout.write("Enter New Scores for ${subject.subjectName} (or press Enter to keep current): ");
    String? newScores = stdin.readLineSync();
    if (newScores != null && newScores.isNotEmpty) {
      subject.testScores = newScores.split(',').map((s) => int.parse(s.trim())).toList();
    }
    subjects.add(subject);
  }
  student.subjects = subjects;

  await StudentService.updateStudent(student);
  print("Student updated successfully.");
}

Future<void> searchStudent() async {
  stdout.write("Enter Student Name or ID to search: ");
  String query = stdin.readLineSync()!;
  List<Student> students = await StudentService.searchStudents(query);

  if (students.isEmpty) {
    print("No matching students found.");
  } else {
    print("\nSearch Results:");
    for (var student in students) {
      print("ID: ${student.id}, Name: ${student.name}");
      for (var subject in student.subjects) {
        print("  Subject: ${subject.subjectName}, Scores: ${subject.testScores.join(', ')}");
      }
    }
  }
}
