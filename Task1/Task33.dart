import 'package:flutter/material.dart';

void main() => runApp(CustomNavApp());

class CustomNavApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomNavScreen(),
    );
  }
}

class CustomNavScreen extends StatefulWidget {
  @override
  _CustomNavScreenState createState() => _CustomNavScreenState();
}

class _CustomNavScreenState extends State<CustomNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text("Home Page", key: ValueKey(0), style: TextStyle(fontSize: 24))),
    Center(child: Text("Search Page", key: ValueKey(1), style: TextStyle(fontSize: 24))),
    Center(child: Text("Profile Page", key: ValueKey(2), style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        color: Colors.blueGrey[900],
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(3, (index) {
            bool selected = index == _currentIndex;
            return GestureDetector(
              onTap: () => setState(() => _currentIndex = index),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    index == 0 ? Icons.home : index == 1 ? Icons.search : Icons.person,
                    color: selected ? Colors.greenAccent : Colors.white,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: EdgeInsets.only(top: 4),
                    child: Text(
                      index == 0 ? "Home" : index == 1 ? "Search" : "Profile",
                      style: TextStyle(
                        fontSize: selected ? 16 : 12,
                        color: selected ? Colors.greenAccent : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
