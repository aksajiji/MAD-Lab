import 'package:flutter/material.dart';

void main() {
  runApp(const ImageGalleryDemo());
}

class ImageGalleryDemo extends StatelessWidget {
  const ImageGalleryDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task 11: Image Gallery')),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(3, (i) => _buildImageTile(context, i + 1)),
      ),
    );
  }

  Widget _buildImageTile(BuildContext context, int number) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image $number tapped')),
        );
      },
      child: Image.network(
        'https://picsum.photos/200?random=$number',
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stack) {
          return Container(
            color: Colors.grey.shade200,
            child: const Center(child: Icon(Icons.broken_image)),
          );
        },
      ),
    );
  }
}
