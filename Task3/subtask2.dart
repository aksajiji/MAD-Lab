
import 'dart:html'; // gives access to localStorage

class FileOperations {
  static const String _key = "notes_file";

  Future<void> writeToFile(String text) async {
    window.localStorage[_key] = text;
  }

  Future<String> readFromFile() async {
    return window.localStorage[_key] ?? '';
  }
}
