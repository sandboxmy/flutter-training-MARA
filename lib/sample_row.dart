import 'package:flutter/material.dart';

/// Sample Row
/// Row = arrange children HORIZONTALLY (left to right).
class SampleRowScreen extends StatelessWidget {
  const SampleRowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Row'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: 60, height: 60, color: Colors.red),
                const SizedBox(width: 8),
                Container(width: 60, height: 60, color: Colors.green),
                const SizedBox(width: 8),
                Container(width: 60, height: 60, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Row = horizontal layout'),
          ],
        ),
      ),
    );
  }
}
