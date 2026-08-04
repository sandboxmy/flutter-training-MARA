import 'package:flutter/material.dart';

/// Sample ListView.builder
/// Builds a scrollable list from a List of Strings.
class SampleListViewBuilderScreen extends StatelessWidget {
  const SampleListViewBuilderScreen({super.key});

  final List<String> tasks = const ['Buy milk', 'Walk dog', 'Study Flutter'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView.builder')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(tasks[index]));
        },
      ),
    );
  }
}
