import 'package:flutter/material.dart';
import 'package:flutter_training_mara/sample_row.dart';

import 'login_screen.dart';
import 'sample_bottom_navigation.dart';
import 'sample_button.dart';
import 'sample_column.dart';
import 'sample_container_widget.dart';
import 'sample_grid_tile.dart';
import 'sample_gridview_builder.dart';
import 'sample_icon.dart';
import 'sample_list_tile.dart';
import 'sample_listview_builder.dart';
import 'sample_navigation.dart';
import 'sample_stack.dart';
import 'sample_stateful_widget.dart';
import 'sample_stateless_widget.dart';
import 'sample_text_widget.dart';
import 'sample_todo_list.dart';
import 'sample_wrap.dart';

/// Home screen after login/register — My Tasks + drawer of samples
class HomePage extends StatefulWidget {
  const HomePage({super.key, this.username = 'User', this.email});

  static const String routeName = '/home';

  final String username;
  final String? email;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color _primary = Color(0xFF6C72C9);

  // Fixed tasks — no create/add UI
  final List<Map<String, dynamic>> _tasks = [
    {'title': 'Laundry', 'done': true},
    {'title': 'Grocery', 'done': true},
    {'title': 'Car wash', 'done': false},
  ];

  // Each item: title + screen to open
  static final List<Map<String, dynamic>> samples = [
    {'title': 'Button', 'screen': const SampleButtonScreen()},
    {
      'title': 'Bottom Navigation',
      'screen': const SampleBottomNavigationScreen(),
    },
    {'title': 'ListTile (Vertical)', 'screen': const SampleListTileScreen()},
    {
      'title': 'ListView.builder',
      'screen': const SampleListViewBuilderScreen(),
    },
    {'title': 'GridTile', 'screen': const SampleGridTileScreen()},
    {
      'title': 'GridView.builder',
      'screen': const SampleGridViewBuilderScreen(),
    },
    {'title': 'StatelessWidget', 'screen': const SampleStatelessWidgetScreen()},
    {'title': 'StatefulWidget', 'screen': const SampleStatefulWidgetScreen()},
    {'title': 'Text Widget', 'screen': const SampleTextWidgetScreen()},
    {
      'title': 'Container Widget',
      'screen': const SampleContainerWidgetScreen(),
    },
    {'title': 'Column', 'screen': const SampleColumnScreen()},
    {'title': 'Row', 'screen': const SampleRowScreen()},
    {'title': 'Stack', 'screen': const SampleStackScreen()},
    {'title': 'Wrap', 'screen': const SampleWrapScreen()},
    {'title': 'Icon', 'screen': const SampleIconScreen()},
    {
      'title': 'Navigation (Pass Data)',
      'screen': const SampleNavigationScreen(),
    },
    {'title': 'Exercise: To-Do List', 'screen': const SampleTodoListScreen()},
  ];

  int get _doneCount => _tasks.where((t) => t['done'] == true).length;

  double get _progress => _tasks.isEmpty ? 0 : _doneCount / _tasks.length;

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['done'] = !(_tasks[index]['done'] as bool);
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      appBar: AppBar(
        title: const Text('My Tasks'),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              setState(() {}); // simple refresh
            },
          ),
          IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: _primary),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, ${widget.username}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (widget.email != null && widget.email!.isNotEmpty)
                      Text(
                        widget.email!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                  ],
                ),
              ),
            ),
            ...List.generate(samples.length, (index) {
              final sample = samples[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: _primary,
                  foregroundColor: Colors.white,
                  child: Text('${index + 1}'),
                ),
                title: Text(sample['title'] as String),
                onTap: () {
                  Navigator.pop(context); // close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => sample['screen'] as Widget,
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Hello, ${widget.username}!',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '${widget.email}',
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
          // Progress card
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progress',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$_doneCount / ${_tasks.length} done',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                      color: _primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Fixed task list (no add field)
          ...List.generate(_tasks.length, (index) {
            final task = _tasks[index];
            final done = task['done'] as bool;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Checkbox(
                    value: done,
                    activeColor: _primary,
                    onChanged: (_) => _toggleTask(index),
                  ),
                  title: Text(
                    task['title'] as String,
                    style: TextStyle(
                      decoration: done ? TextDecoration.lineThrough : null,
                      color: done ? Colors.grey : Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onTap: () => _toggleTask(index),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
