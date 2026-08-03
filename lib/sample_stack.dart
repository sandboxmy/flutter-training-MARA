import 'package:flutter/material.dart';

/// Sample Stack
/// Stack = place widgets ON TOP of each other (layers).
class SampleStackScreen extends StatelessWidget {
  const SampleStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Stack'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Bottom layer
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
                // Middle layer
                Container(
                  width: 120,
                  height: 120,
                  color: Colors.orange,
                ),
                // Top layer
                const Text(
                  'On Top',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Stack = widgets layered on top of each other'),
          ],
        ),
      ),
    );
  }
}
