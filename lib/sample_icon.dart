import 'package:flutter/material.dart';

/// Sample Icon
/// Shows common Icon usage and properties.
class SampleIconScreen extends StatelessWidget {
  const SampleIconScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Icon'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic icon
            Icon(Icons.home),
            SizedBox(height: 8),
            Text('Icons.home'),

            SizedBox(height: 24),

            // Big colored icon
            Icon(
              Icons.favorite,
              color: Colors.red,
              size: 48,
            ),
            SizedBox(height: 8),
            Text('Icons.favorite (red, size 48)'),

            SizedBox(height: 24),

            // Icon with text in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 8),
                Text('Call Me'),
              ],
            ),

            SizedBox(height: 24),

            // More icons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber, size: 36),
                Icon(Icons.star, color: Colors.amber, size: 36),
                Icon(Icons.star, color: Colors.amber, size: 36),
                Icon(Icons.star_border, color: Colors.amber, size: 36),
                Icon(Icons.star_border, color: Colors.amber, size: 36),
              ],
            ),
            SizedBox(height: 8),
            Text('Star rating icons'),
          ],
        ),
      ),
    );
  }
}
