import 'package:flutter/material.dart';

void main() => runApp(SpotifyCloneApp());

class SpotifyCloneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpotifyAlbumPage(),
    );
  }
}

class SpotifyAlbumPage extends StatelessWidget {
  final List<String> songs = [
    "Track 1 - Flutter Beats",
    "Track 2 - Widget Symphony",
    "Track 3 - Layout Harmony",
    "Track 4 - Gesture Jam",
    "Track 5 - State Rock"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Now Playing"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("https://i.scdn.co/image/ab67616d0000b273b0a3f2b0b64b7fdf64c4dff0"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: Colors.black.withOpacity(0.6)),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100),
                Container(
                  height: 200,
                  width: 200,
                  child: Image.network("https://i.scdn.co/image/ab67616d0000b273b0a3f2b0b64b7fdf64c4dff0"),
                ),
                SizedBox(height: 20),
                Text("Flutter Symphony",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                Text("Aksa Jiji Thomas",
                    style: TextStyle(fontSize: 18, color: Colors.grey[300])),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: Icon(Icons.shuffle, color: Colors.white), onPressed: () {}),
                    IconButton(icon: Icon(Icons.skip_previous, color: Colors.white), onPressed: () {}),
                    IconButton(icon: Icon(Icons.play_circle_fill, size: 48, color: Colors.green), onPressed: () {}),
                    IconButton(icon: Icon(Icons.skip_next, color: Colors.white), onPressed: () {}),
                    IconButton(icon: Icon(Icons.repeat, color: Colors.white), onPressed: () {}),
                  ],
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: songs.length,
                  separatorBuilder: (_, __) => Divider(color: Colors.white30),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(songs[index], style: TextStyle(color: Colors.white)),
                      leading: Icon(Icons.music_note, color: Colors.white),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
