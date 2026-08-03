import 'package:flutter/material.dart';

/// Sample Text Widget
/// Shows common Text styles and properties.
class SampleTextWidgetScreen extends StatelessWidget {
  const SampleTextWidgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Text Widget'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Basic text
            Text('1. Basic Text'),

            SizedBox(height: 16),

            // Big text
            Text(
              '2. Big Bold Text',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),

            // Colored text
            Text(
              '3. Colored Text',
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),

            SizedBox(height: 16),

            // Italic text
            Text(
              '4. Italic Text',
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ),

            SizedBox(height: 16),

            // Centered text
            Text(
              '5. Centered Text with max lines',
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),

            SizedBox(height: 16),

            // Underlined text
            Text(
              '6. Underlined Text',
              style: TextStyle(
                fontSize: 20,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
