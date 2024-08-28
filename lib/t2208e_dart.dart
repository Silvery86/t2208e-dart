// Binary search function
int binarySearch(List<int> sortedList, int target) {
  int left = 0;
  int right = sortedList.length - 1;
  while (left <= right) {
    int mid = left + (right - left) ~/ 2;
    if (sortedList[mid] == target) {
      return mid; // Target found, return the index
    } else if (sortedList[mid] < target) {
      left = mid + 1; // Ignore the left half
    } else {
      right = mid - 1; // Ignore the right half
    }
  }
  return -1; // Target not found
}

// Function to calculate the user's age
int calculateAge(DateTime dob, DateTime today) {
  int age = today.year - dob.year;
  if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
    age--;
  }
  return age;
}

// Function to check if today is the user's birthday
bool isBirthday(DateTime dob, DateTime today) {
  return today.month == dob.month && today.day == dob.day;
}

// Function to calculate years until the user turns 100
int yearsUntil100(int age) {
  return 100 - age;
}