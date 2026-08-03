import 'package:flutter/material.dart';

/// Sample Column
/// Column = arrange children VERTICALLY (top to bottom).
class SampleColumnScreen extends StatelessWidget {
  const SampleColumnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Column'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 100, height: 50, color: Colors.red),
            const SizedBox(height: 8),
            Container(width: 100, height: 50, color: Colors.green),
            const SizedBox(height: 8),
            Container(width: 100, height: 50, color: Colors.blue),
            const SizedBox(height: 16),
            const Text('Column = vertical layout'),
          ],
        ),
      ),
    );
  }
}
