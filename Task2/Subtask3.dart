import 'package:flutter/material.dart';

void main() => runApp(ECommerceApp());

class ECommerceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainHub(),
    );
  }
}

class MainHub extends StatefulWidget {
  @override
  _MainHubState createState() => _MainHubState();
}

class _MainHubState extends State<MainHub> {
  int _selectedIndex = 0;
  final _pages = [HomePage(), CartPage(), ProfilePage()];

  void _onTap(int idx) => setState(() => _selectedIndex = idx);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(["Home", "Cart", "Profile"][_selectedIndex])),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ------------------- Pages -------------------

class HomePage extends StatelessWidget {
  final products = List.generate(
      6,
      (i) => {
            "name": "Product ${i + 1}",
            "price": "\$${(i + 1) * 20}",
            "img": "https://picsum.photos/200?random=$i"
          });

  @override
  Widget build(BuildContext context) => GridView.builder(
        padding: EdgeInsets.all(12),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.8, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: products.length,
        itemBuilder: (_, i) => Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(products[i]["img"]!, fit: BoxFit.cover))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(products[i]["name"]!, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text(products[i]["price"]!, style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class CartPage extends StatelessWidget {
  final cartItems = [
    {"name": "Product 1", "price": "\$20"},
    {"name": "Product 3", "price": "\$60"}
  ];

  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: EdgeInsets.all(12),
        itemCount: cartItems.length,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (_, i) => ListTile(
          leading: CircleAvatar(child: Text(cartItems[i]["name"]![8])),
          title: Text(cartItems[i]["name"]!),
          subtitle: Text(cartItems[i]["price"]!),
          trailing: Icon(Icons.delete, color: Colors.red),
        ),
      );
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://picsum.photos/200")),
            SizedBox(height: 16),
            Text("Aksa Jiji Thomas", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("aksa@email.com"),
            SizedBox(height: 20),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ListTile(leading: Icon(Icons.history), title: Text("Order History")),
            ListTile(leading: Icon(Icons.logout), title: Text("Logout")),
          ],
        ),
      );
}

