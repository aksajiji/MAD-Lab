import 'package:flutter/material.dart';

void main() => runApp(DraggableNotesApp());

class DraggableNotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesBoard(),
    );
  }
}

class NotesBoard extends StatefulWidget {
  @override
  _NotesBoardState createState() => _NotesBoardState();
}

class _NotesBoardState extends State<NotesBoard> {
  List<NoteWidget> notes = [];

  void _addNote() {
    setState(() {
      notes.add(NoteWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Draggable Notes")),
      body: Stack(children: notes),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addNote,
      ),
    );
  }
}

class NoteWidget extends StatefulWidget {
  @override
  _NoteWidgetState createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  Offset position = Offset(100, 100);
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
          });
        },
        onScaleUpdate: (details) {
          setState(() {
            scale = details.scale.clamp(0.5, 2.0);
          });
        },
        child: Transform.scale(
          scale: scale,
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow[200],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Text("Note 📝", style: TextStyle(fontSize: 18)),
          ),
        ),
      ),
    );
  }
}
