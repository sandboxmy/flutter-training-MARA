import 'package:flutter/material.dart';

/// Sample GridTile
/// Shows items in a grid layout using GridView.
class SampleGridTileScreen extends StatelessWidget {
  const SampleGridTileScreen({super.key});

  static const List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.amber,
    Colors.indigo,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample GridTile'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        // How many columns
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) {
          return GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black45,
              title: Text('Item ${index + 1}'),
            ),
            child: Container(
              color: colors[index],
              child: const Center(
                child: Icon(Icons.star, color: Colors.white, size: 40),
              ),
            ),
          );
        },
      ),
    );
  }
}
