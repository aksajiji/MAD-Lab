import 'package:flutter/material.dart';

void main() => runApp(MoodLifterApp());

class MoodLifterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: Scaffold(
        appBar: AppBar(title: Text("Mood Lifter 😊")),
        body: MoodLifterCard(
          name: "Aksa Jiji Thomas",
          bio: "Flutter enthusiast • Loves animations",
        ),
      ),
    );
  }
}

class MoodLifterCard extends StatefulWidget {
  final String name;
  final String bio;

  const MoodLifterCard({required this.name, required this.bio});

  @override
  State<MoodLifterCard> createState() => _MoodLifterCardState();
}

class _MoodLifterCardState extends State<MoodLifterCard>
    with SingleTickerProviderStateMixin {
  bool isHappy = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _scaleAnimation =
        Tween<double>(begin: 0.9, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticInOut,
    ));

    _colorAnimation =
        ColorTween(begin: Colors.grey.shade300, end: Colors.yellow.shade600)
            .animate(_controller);
  }

  void toggleMood() {
    setState(() {
      isHappy = !isHappy;
      isHappy ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: toggleMood,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedBuilder(
            animation: _colorAnimation,
            builder: (context, child) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _colorAnimation.value,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6))
                  ],
                ),
                width: 320,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: isHappy ? 60 : 50,
                      backgroundImage:
                          NetworkImage("https://content.pexels.com/images/canva/ai-generated-ad/single-image/nature/rainkissed_forest-full.jpg"),
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(height: 14),
                    Text(widget.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 6),
                    Text(widget.bio,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 15)),
                    SizedBox(height: 16),
                    Icon(
                      isHappy
                          ? Icons.sentiment_very_satisfied
                          : Icons.sentiment_dissatisfied,
                      color: isHappy ? Colors.orange : Colors.blueGrey,
                      size: 40,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Tap the card to ${isHappy ? "relax 😌" : "cheer up 🎉"}",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
