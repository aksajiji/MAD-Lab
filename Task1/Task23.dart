import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(DatePickerFormApp());

class DatePickerFormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatePickerForm(),
    );
  }
}

class DatePickerForm extends StatefulWidget {
  @override
  _DatePickerFormState createState() => _DatePickerFormState();
}

class _DatePickerFormState extends State<DatePickerForm> {
  final _formKey = GlobalKey<FormState>();
  String? name;
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Date Picker Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value != null && value.isNotEmpty ? null : "Enter your name",
                onSaved: (value) => name = value,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (picked != null) {
                    setState(() => _selectedDate = picked);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    _selectedDate == null
                        ? "Select Date of Birth"
                        : DateFormat("dd-MM-yyyy").format(_selectedDate!),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Submit"),
                onPressed: () {
                  if (_formKey.currentState!.validate() &&
                      _selectedDate != null) {
                    _formKey.currentState!.save();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Hello $name, DOB: "
                            "${DateFormat("dd-MM-yyyy").format(_selectedDate!)}"),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please complete the form")),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
