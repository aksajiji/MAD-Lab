import 'package:flutter/material.dart';

void main() => runApp(MultiStepFormApp());

class MultiStepFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiStepForm(),
    );
  }
}

class MultiStepForm extends StatefulWidget {
  @override
  _MultiStepFormState createState() => _MultiStepFormState();
}

class _MultiStepFormState extends State<MultiStepForm> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  String? email, password, name, phone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Multi-Step Form")),
      body: Form(
        key: _formKey,
        child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
      ),
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Email"),
            validator: (value) =>
                value != null && value.contains("@") ? null : "Invalid email",
            onSaved: (value) => email = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) =>
                value != null && value.length >= 6 ? null : "Password too short",
            onSaved: (value) => password = value,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Next"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() => _currentStep = 1);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: "Name"),
            validator: (value) =>
                value != null && value.isNotEmpty ? null : "Enter your name",
            onSaved: (value) => name = value,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "Phone Number"),
            keyboardType: TextInputType.phone,
            validator: (value) =>
                value != null && value.length == 10 ? null : "Enter valid phone",
            onSaved: (value) => phone = value,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Submit"),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Registration Successful! 🎉")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
