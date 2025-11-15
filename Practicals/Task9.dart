import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  runApp(const TestExampleApp());
}

class TestExampleApp extends StatelessWidget {
  const TestExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Text widget appears on screen', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Text('Hello'),
        ),
      ),
    );

    // Expect the text to appear once
    expect(find.text('Hello'), findsOneWidget);
  });
}

