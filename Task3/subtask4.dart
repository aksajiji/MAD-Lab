//main.dart
import 'package:flutter/material.dart';
import 'repository/file_operations.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesApp(),
    );
  }
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  final TextEditingController _controller = TextEditingController();
  final FileOperations fileOps = FileOperations();

  @override
  void initState() {
    super.initState();
    _loadText();
  }

  Future<void> _saveText() async {
    await fileOps.writeToFile(_controller.text);

    // ✅ Use ScaffoldMessenger tied to this context
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Note saved successfully!")),
      );
    }
  }

  Future<void> _loadText() async {
    _controller.text = await fileOps.readFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personal Notes')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: "Enter your note",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(onPressed: _saveText, child: const Text("Save")),
                ElevatedButton(onPressed: _loadText, child: const Text("Load")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
