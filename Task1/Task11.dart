// Social Media Profile Card
import 'package:flutter/material.dart';

void main() => runApp(ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Profile Card"),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.settings))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=47",
                ),
              ),
              SizedBox(height: 12),
              Text(
                "Aksa Jiji Thomas",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                "BTech Student | Flutter Enthusiast",
                style: TextStyle(color: Colors.grey[600]),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStat("120", "Posts"),
                  _buildStat("500", "Followers"),
                  _buildStat("300", "Following"),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(label),
      ],
    );
  }
}
