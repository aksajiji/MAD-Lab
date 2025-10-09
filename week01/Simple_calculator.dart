import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  final TextEditingController _num1 = TextEditingController();
  final TextEditingController _num2 = TextEditingController();
  String result = "";

  void _calculate(String op) {
    double n1 = double.tryParse(_num1.text) ?? 0;
    double n2 = double.tryParse(_num2.text) ?? 0;
    double res;

    switch (op) {
      case '+':
        res = n1 + n2;
        break;
      case '-':
        res = n1 - n2;
        break;
      case '*':
        res = n1 * n2;
        break;
      case '/':
        res = n2 != 0 ? n1 / n2 : double.nan;
        break;
      default:
        res = 0;
    }

    setState(() {
      result = "Result: $res";
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Calculator")),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(controller: _num1, decoration: const InputDecoration(labelText: "Enter first number")),
              TextField(controller: _num2, decoration: const InputDecoration(labelText: "Enter second number")),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: () => _calculate('+'), child: const Text("+")),
                  ElevatedButton(onPressed: () => _calculate('-'), child: const Text("-")),
                  ElevatedButton(onPressed: () => _calculate('*'), child: const Text("*")),
                  ElevatedButton(onPressed: () => _calculate('/'), child: const Text("/")),
                ],
              ),
              const SizedBox(height: 20),
              Text(result, style: const TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
