import 'package:flutter/material.dart';

/// Sample ListTile (Vertical List)
/// Shows a scrollable vertical list using ListView and ListTile.
class SampleListTileScreen extends StatelessWidget {
  const SampleListTileScreen({super.key});

  // Sample data
  static const List<String> fruits = [
    'Apple',
    'Banana',
    'Orange',
    'Mango',
    'Grapes',
    'Watermelon',
    'Pineapple',
    'Strawberry',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample ListTile'),
      ),
      body: ListView.builder(
        itemCount: fruits.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.apple),
            title: Text(fruits[index]),
            subtitle: Text('Item number ${index + 1}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              print('Tapped: ${fruits[index]}');
            },
          );
        },
      ),
    );
  }
}
