import 'package:flutter/material.dart';

void main() {
  runApp(const FadeAnimationApp());
}

class FadeAnimationApp extends StatelessWidget {
  const FadeAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FadeScreen(),
    );
  }
}

class FadeScreen extends StatefulWidget {
  const FadeScreen({super.key});

  @override
  State<FadeScreen> createState() => _FadeScreenState();
}

class _FadeScreenState extends State<FadeScreen> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    // Make it visible after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _visible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fade-In Animation"),
        centerTitle: true,
      ),
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(seconds: 1),
          opacity: _visible ? 1.0 : 0.0,
          child: const Text(
            "Welcome!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
