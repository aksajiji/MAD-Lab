import 'package:flutter/material.dart';

void main() {
  runApp(const DraggableDemo());
}

class DraggableDemo extends StatelessWidget {
  const DraggableDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DragScreen(),
    );
  }
}

class DragScreen extends StatefulWidget {
  const DragScreen({super.key});

  @override
  State<DragScreen> createState() => _DragScreenState();
}

class _DragScreenState extends State<DragScreen> {
  Color _targetColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 10: Draggable & DragTarget')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Draggable<String>(
              data: 'blue-box',
              child: Container(
                width: 120,
                height: 120,
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Drag me', style: TextStyle(color: Colors.white)),
              ),
              feedback: Material(
                color: Colors.transparent,
                child: Opacity(
                  opacity: 0.6,
                  child: Container(
                    width: 120,
                    height: 120,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text('Drag me', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              childWhenDragging: Container(
                width: 120,
                height: 120,
                color: Colors.blue.shade200,
                alignment: Alignment.center,
                child: const Text('Dragging', style: TextStyle(color: Colors.white70)),
              ),
            ),
          ),
          DragTarget<String>(
            onAccept: (value) {
              setState(() => _targetColor = Colors.green);
            },
            onWillAccept: (value) => true,
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 150,
                height: 150,
                color: _targetColor,
                alignment: Alignment.center,
                child: const Text('Drop Here', style: TextStyle(color: Colors.white)),
              );
            },
          ),
        ],
      ),
    );
  }
}
