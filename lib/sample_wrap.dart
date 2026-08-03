import 'package:flutter/material.dart';

/// Sample Wrap
/// Wrap = like Row/Column, but items move to next line when no space.
class SampleWrapScreen extends StatelessWidget {
  const SampleWrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Wrap'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wrap moves items to the next line automatically:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8, // space between items horizontally
              runSpacing: 8, // space between lines
              children: List.generate(12, (index) {
                return Chip(
                  label: Text('Item ${index + 1}'),
                  backgroundColor: Colors.blue.shade100,
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
