import 'dart:io';
import 'package:t2208e_dart/t2208e_dart.dart';

void main(List<String> arguments) {
  // Binary search
  List<int> sortedList = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
  // Prompt user to enter the target value
  stdout.write('Enter the target value: ');
  int? target = int.tryParse(stdin.readLineSync()!);
  if (target != null) {
    int result = binarySearch(sortedList, target);
    if (result != -1) {
      print('Target found at index $result');
    } else {
      print('Target not found');
    }
  } else {
    print('Invalid input. Please enter a valid integer.');
  }

  // Year old lab
  // Input: User's name
  stdout.write('Enter your name: ');
  String? name = stdin.readLineSync();
  // Input: User's date of birth
  stdout.write('Enter your date of birth (YYYY-MM-DD): ');
  String? dobInput = stdin.readLineSync();
  if (name != null && dobInput != null) {
    // Parse the date of birth input
    DateTime? dob = DateTime.tryParse(dobInput);
    if (dob != null) {
      // Get today's date
      DateTime today = DateTime.now();
      // Calculate age
      int age = calculateAge(dob, today);
      // Check if today is the user's birthday
      if (isBirthday(dob, today)) {
        print('Happy Birthday $age years old, $name!');
      }
      print('You are $age years old.');
      // Calculate years until 100
      int yearsUntil100Value = yearsUntil100(age);
      if (yearsUntil100Value > 0) {
        print('You will be 100 years old in $yearsUntil100Value years.');
      } else if (yearsUntil100Value == 0) {
        print('Congratulations, you are 100 years old this year!');
      } else {
        print('You turned 100 years old ${-yearsUntil100Value} years ago.');
      }
    } else {
      print('Invalid date format. Please use YYYY-MM-DD.');
    }
  } else {
    print('Please provide both your name and date of birth.');
  }
}
