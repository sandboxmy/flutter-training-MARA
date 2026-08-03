import 'package:flutter/material.dart';

/// EXERCISE: Static To-Do List
/// - Root: padded Container
/// - Layout: Column
/// - Children: two ListTile widgets (title + subtitle)
class SampleTodoListScreen extends StatelessWidget {
  const SampleTodoListScreen({super.key});

  static const String routeName = '/todo-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Static To-Do List'),
        backgroundColor: const Color(0xFF6C72C9),
        foregroundColor: Colors.white,
      ),
      body: Container(
        // Root widget with padding
        padding: const EdgeInsets.all(16),
        child: Column(
          // Layout widget
          children: [
            // ListTile 1
            ListTile(
              title: const Text('Task 1: Buy groceries'),
              subtitle: const Text('Remember to buy milk and eggs'),
              trailing: const Icon(Icons.check_box_outline_blank),
              onTap: () {
                print('Task 1 tapped');
              },
            ),

            // ListTile 2
            ListTile(
              title: const Text('Task 2: Morning Run'),
              subtitle: const Text('Run 3km in the park'),
              trailing: const Icon(Icons.check_box_outline_blank),
              onTap: () {
                print('Task 2 tapped');
              },
            ),
          ],
        ),
      ),
    );
  }
}
