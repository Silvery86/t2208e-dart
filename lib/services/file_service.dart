import 'dart:io';
import 'dart:convert';

class FileService {
  static Future<List<dynamic>> readJsonFile(String path) async {
    final file = File(path);
    if (!await file.exists()) {
      return [];
    }
    String contents = await file.readAsString();
    return jsonDecode(contents);
  }

  static Future<void> writeJsonFile(String path, List<dynamic> data) async {
    final file = File(path);
    await file.writeAsString(jsonEncode(data));
  }
}
