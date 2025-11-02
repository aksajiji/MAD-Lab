import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'models/post.dart';
void main() {
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Firebase Flutter Lab (Zapp.run)',
theme: ThemeData(primarySwatch: Colors.indigo),
home: const HomeScreen(),
);
}
}
class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});

@override
State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
final titleController = TextEditingController();
final messageController = TextEditingController();
final String firebaseUrl =
'https://flutter-lab-app-b3727-default-rtdb.firebaseio.com/posts.json';
List<Post> posts = [];
@override
void initState() {
super.initState();
_fetchPosts();
}
Future<void> _fetchPosts() async {
try {
final response = await HttpRequest.getString(firebaseUrl);
final Map<String, dynamic> data =
jsonDecode(response ?? '{}') as Map<String, dynamic>;
final loadedPosts = data.entries.map((entry) {
final map = Map<String, dynamic>.from(entry.value);
return Post.fromMap(entry.key, map);
}).toList();
loadedPosts.sort((a, b) => b.timestamp.compareTo(a.timestamp));
setState(() {
posts = loadedPosts;
});
} catch (e) {
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text('Failed to fetch posts: $e')));
}
}
Future<void> _addPost() async {
final title = titleController.text.trim();
final message = messageController.text.trim();
if (title.isEmpty || message.isEmpty) return;
final post = Post(title: title, message: message);
try {
final req = HttpRequest();
req
..open('POST', firebaseUrl)
..setRequestHeader('Content-Type', 'application/json')
..onLoadEnd.listen((event) {
final responseData = jsonDecode(req.responseText ?? '{}');
final newPostId = responseData['name'];
final newPost = Post(
id: newPostId,
title: post.title,
message: post.message,
timestamp: post.timestamp,
);

setState(() {
posts.insert(0, newPost);
});
titleController.clear();
messageController.clear();
ScaffoldMessenger.of(context)
.showSnackBar(const SnackBar(content: Text('Post added ✅')));
})
..send(jsonEncode(post.toMap()));
} catch (e) {
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text('Failed to add post: $e')));
}
}
Future<void> _deletePost(String id) async {
final url =
'https://flutter-lab-app-b3727-default-rtdb.firebaseio.com/posts/$id.json';
try {
await HttpRequest.request(url, method: 'DELETE');
setState(() {
posts.removeWhere((p) => p.id == id);
});
ScaffoldMessenger.of(context)
.showSnackBar(const SnackBar(content: Text('Post deleted ️')));
} catch (e) {
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text('Failed to delete post: $e')));
}
}
Future<void> _editPost(Post post) async {
final titleController = TextEditingController(text: post.title);
final messageController = TextEditingController(text: post.message);
final updated = await showDialog<Post>(
context: context,
builder: (context) => AlertDialog(
title: const Text('Edit Post'),
content: Column(
mainAxisSize: MainAxisSize.min,
children: [
TextField(
controller: titleController,
decoration: const InputDecoration(labelText: 'Title'),
),
TextField(
controller: messageController,
decoration: const InputDecoration(labelText: 'Message'),
),
],
),
actions: [
TextButton(
onPressed: () => Navigator.pop(context),
child: const Text('Cancel')),

ElevatedButton(
onPressed: () {
final newPost = Post(
id: post.id,
title: titleController.text,
message: messageController.text,
timestamp: DateTime.now());
Navigator.pop(context, newPost);
},
child: const Text('Save')),
],
),
);
if (updated != null && post.id != null) {
final url =
'https://flutter-lab-app-b3727-default-rtdb.firebaseio.com/posts/${post.id}.json';
try {
await HttpRequest.request(
url,
method: 'PATCH',
sendData: jsonEncode(updated.toMap()),
requestHeaders: {'Content-Type': 'application/json'},
);
setState(() {
final index = posts.indexWhere((p) => p.id == post.id);
if (index != -1) posts[index] = updated;
});
ScaffoldMessenger.of(context)
.showSnackBar(const SnackBar(content: Text('Post updated ✏️')));
} catch (e) {
ScaffoldMessenger.of(context)
.showSnackBar(SnackBar(content: Text('Failed to edit post: $e')));
}
}
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Firebase Flutter Lab')),
body: Padding(
padding: const EdgeInsets.all(12),
child: Column(
children: [
TextField(
controller: titleController,
decoration: const InputDecoration(labelText: 'Title'),
),
const SizedBox(height: 8),
TextField(
controller: messageController,
decoration: const InputDecoration(labelText: 'Message'),
),
const SizedBox(height: 12),
ElevatedButton(onPressed: _addPost, child: const Text('Add Post')),
const SizedBox(height: 20),
Expanded(

child: posts.isEmpty
? const Center(child: Text('No posts yet — add one!'))
: ListView.builder(
itemCount: posts.length,
itemBuilder: (context, idx) {
final p = posts[idx];
final time = p.timestamp;
final timeStr =
'${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}
${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
return Card(
margin: const EdgeInsets.symmetric(vertical: 6),
child: ListTile(
title: Text(p.title),
subtitle: Text(p.message),
isThreeLine: true,
trailing: Row(
mainAxisSize: MainAxisSize.min,
children: [
IconButton(
icon: const Icon(Icons.edit,
color: Colors.blue),
onPressed: () => _editPost(p),
),
IconButton(
icon: const Icon(Icons.delete,
color: Colors.red),
onPressed: () => _deletePost(p.id!),
),
],
),
),
);
},
),
),
],
),
),
);
}
}