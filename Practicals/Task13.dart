import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedContainerDemo());
}

class AnimatedContainerDemo extends StatelessWidget {
  const AnimatedContainerDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedBoxScreen(),
    );
  }
}

class AnimatedBoxScreen extends StatefulWidget {
  const AnimatedBoxScreen({super.key});

  @override
  State<AnimatedBoxScreen> createState() => _AnimatedBoxScreenState();
}

class _AnimatedBoxScreenState extends State<AnimatedBoxScreen> {
  double _width = 100;
  double _height = 100;

  void _toggleSize() {
    setState(() {
      if (_width == 100) {
        _width = 200;
        _height = 200;
      } else {
        _width = 100;
        _height = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 13: Animated Container')),
      body: Center(
        child: AnimatedContainer(
          width: _width,
          height: _height,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleSize,
        child: const Icon(Icons.aspect_ratio),
      ),
    );
  }
}
