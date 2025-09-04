import 'package:flutter/material.dart';

void main() => runApp(DynamicFormApp());

class DynamicFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DynamicForm(),
    );
  }
}

class DynamicForm extends StatefulWidget {
  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  List<TextEditingController> controllers = [];

  void _addTextField() {
    setState(() {
      controllers.add(TextEditingController());
    });
  }

  void _removeTextField(int index) {
    setState(() {
      controllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dynamic Form Fields")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: controllers.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: TextFormField(
                      controller: controllers[index],
                      decoration: InputDecoration(labelText: "Field ${index + 1}"),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => _removeTextField(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: _addTextField,
              icon: Icon(Icons.add),
              label: Text("Add Field"),
            ),
          ],
        ),
      ),
    );
  }
}
