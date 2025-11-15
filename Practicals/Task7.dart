import 'dart:convert';
import 'package:flutter/material.dart';

void main() {
  runApp(const JsonListApp());
}

class JsonListApp extends StatelessWidget {
  const JsonListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JsonListScreen(),
    );
  }
}

class JsonListScreen extends StatelessWidget {
  const JsonListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Local JSON String
    String jsonString = '''
    [
      {"name": "Apple"},
      {"name": "Banana"},
      {"name": "Orange"}
    ]
    ''';

    // Decode JSON into a List
    List<dynamic> fruits = json.decode(jsonString);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Local JSON List"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.check_circle_outline),
            title: Text(fruits[index]["name"]),
          );
        },
      ),
    );
  }
}
