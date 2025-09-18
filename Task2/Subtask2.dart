import 'package:flutter/material.dart';

void main() => runApp(OnboardingApp());

class OnboardingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (_) => OnboardingScreen(),
        '/home': (_) => HomeScreen(),
      },
    );
  }
}

// ==========================
// Onboarding Screen
// ==========================
class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> fade1;
  late Animation<Offset> slide2;
  late Animation<double> scale3;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2500));

    fade1 = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.3)),
    );
    slide2 = Tween(begin: Offset(0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 0.6)),
    );
    scale3 = Tween(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0)),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          FadeTransition(
              opacity: fade1,
              child: Text("Welcome!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))),
          SizedBox(height: 20),
          SlideTransition(
              position: slide2,
              child: Image.network("https://picsum.photos/400/200", height: 150)),
          SizedBox(height: 20),
          ScaleTransition(
              scale: scale3,
              child: Icon(Icons.star, color: Colors.amber, size: 60)),
          SizedBox(height: 20),
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
            child: Text("Skip"),
          )
        ]),
      ),
    );
  }
}

// ==========================
// Home Screen
// ==========================
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text(
            "Welcome to Home! 🎉",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(Icons.star, color: Colors.amber, size: 40),
              title: Text("Featured Item"),
              subtitle: Text("Check out this awesome feature!"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {},
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Quick Actions",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActionCard(Icons.shop, "Shop"),
              _buildActionCard(Icons.favorite, "Favorites"),
              _buildActionCard(Icons.settings, "Settings"),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Recommended for you",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          Container(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, i) => Container(
                width: 140,
                margin: EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage("https://picsum.photos/200?random=$i"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(4),
                    child: Text(
                      "Item ${i + 1}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildActionCard(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.blue.shade100,
          child: Icon(icon, size: 30, color: Colors.blue),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
