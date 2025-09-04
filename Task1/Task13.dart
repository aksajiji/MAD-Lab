import 'package:flutter/material.dart';

void main() => runApp(RichTextApp());

class RichTextApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContentToggle(),
    );
  }
}

class ContentToggle extends StatefulWidget {
  @override
  _ContentToggleState createState() => _ContentToggleState();
}

class _ContentToggleState extends State<ContentToggle> {
  bool _showFullText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("RichText Toggle")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16),
                children: [
                  TextSpan(text: "Flutter is amazing! "),
                  if (_showFullText)
                    TextSpan(
                      text:
                          "With widgets, layouts, and gestures, you can build stunning apps. It's flexible, reactive, and fun to use!",
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _showFullText = !_showFullText;
                });
              },
              child: Text(_showFullText ? "Read Less" : "Read More"),
            )
          ],
        ),
      ),
    );
  }
}
