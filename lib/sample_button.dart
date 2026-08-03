import 'package:flutter/material.dart';

/// Sample Button Screen
/// All button examples live here so students can learn in one place.
class SampleButtonScreen extends StatelessWidget {
  const SampleButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 1. ElevatedButton - common button with background color
            ElevatedButton(
              onPressed: () {
                print('ElevatedButton clicked!');
              },
              child: const Text('Elevated Button'),
            ),

            const SizedBox(height: 16),

            // 2. TextButton - simple text-only button
            TextButton(
              onPressed: () {
                print('TextButton clicked!');
              },
              child: const Text('Text Button'),
            ),

            const SizedBox(height: 16),

            // 3. OutlinedButton - button with border
            OutlinedButton(
              onPressed: () {
                print('OutlinedButton clicked!');
              },
              child: const Text('Outlined Button'),
            ),

            const SizedBox(height: 16),

            // 4. Custom button widget (our own widget)
            SampleButton(
              label: 'Custom Button',
              onPressed: () {
                print('Custom SampleButton clicked!');
              },
            ),

            const SizedBox(height: 32),

            // 5. Go back to the previous screen
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

/// A simple reusable button widget.
/// Shows students how to create their own widget.
class SampleButton extends StatelessWidget {
  const SampleButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
