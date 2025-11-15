import 'package:flutter/material.dart';

void main() {
  runApp(const ColorToggleApp());
}

class ColorToggleApp extends StatelessWidget {
  const ColorToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ColorToggleScreen(),
    );
  }
}

class ColorToggleScreen extends StatefulWidget {
  const ColorToggleScreen({super.key});

  @override
  State<ColorToggleScreen> createState() => _ColorToggleScreenState();
}

class _ColorToggleScreenState extends State<ColorToggleScreen> {
  Color _backgroundColor = Colors.white;

  void _toggleColor() {
    setState(() {
      _backgroundColor = _backgroundColor == Colors.white ? Colors.blue : Colors.white;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(title: const Text('Task 12: Color Toggler')),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleColor,
        child: const Icon(Icons.color_lens),
      ),
      body: const Center(child: Text('Press the button to toggle color')),
    );
  }
}
