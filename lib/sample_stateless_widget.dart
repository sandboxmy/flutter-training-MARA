import 'package:flutter/material.dart';

/// Sample StatelessWidget
/// StatelessWidget = UI that does NOT change.
/// Use when the screen has no changing data (no setState).
class SampleStatelessWidgetScreen extends StatelessWidget {
  const SampleStatelessWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample StatelessWidget'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info, size: 64, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'This is a StatelessWidget',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'The UI never changes by itself.\nNo setState is needed.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            // Another StatelessWidget example
            HelloCard(name: 'Flutter Student'),
          ],
        ),
      ),
    );
  }
}

/// Simple custom StatelessWidget
class HelloCard extends StatelessWidget {
  const HelloCard({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text('Hello, $name!'),
      ),
    );
  }
}
