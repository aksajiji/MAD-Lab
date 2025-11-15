import 'package:flutter/material.dart';

void main() {
  runApp(const ActionButtonsApp());
}

class ActionButtonsApp extends StatelessWidget {
  const ActionButtonsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ActionButtonsScreen(),
    );
  }
}

class ActionButtonsScreen extends StatelessWidget {
  const ActionButtonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Action Buttons Row"),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.call),
              iconSize: 40,
              onPressed: () {
                print("Call button pressed");
              },
            ),
            IconButton(
              icon: const Icon(Icons.message),
              iconSize: 40,
              onPressed: () {
                print("Message button pressed");
              },
            ),
            IconButton(
              icon: const Icon(Icons.email),
              iconSize: 40,
              onPressed: () {
                print("Email button pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}
