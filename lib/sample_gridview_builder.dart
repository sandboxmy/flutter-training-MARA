import 'package:flutter/material.dart';

/// Sample GridView.builder
/// Builds a 2-column grid from a List of Strings.
class SampleGridViewBuilderScreen extends StatelessWidget {
  const SampleGridViewBuilderScreen({super.key});

  final List<String> tasks = const ['Buy milk', 'Walk dog', 'Study Flutter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GridView.builder')),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return Card(child: Center(child: Text(tasks[index])));
          },
        ),
      ),
    );
  }
}
