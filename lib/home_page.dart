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
import 'sample_news_api.dart';
import 'sample_stack.dart';
import 'sample_stateful_widget.dart';
import 'sample_stateless_widget.dart';
import 'sample_text_widget.dart';
import 'sample_todo_list.dart';
import 'sample_wrap.dart';

/// Home screen after login/register — user info + drawer of samples
class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.username = 'User',
    this.email,
    this.token,
  });

  static const String routeName = '/home';

  final String username;
  final String? email;

  /// Auth token from login/register (in memory only — not SharedPreferences yet)
  final String? token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color _primary = Color(0xFF6C72C9);

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
    {'title': 'Public News API', 'screen': const NewsAPI()},
    {'title': 'Exercise: To-Do List', 'screen': const SampleTodoListScreen()},
  ];

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, ${widget.username}!',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              '${widget.email}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Text(
              'My token: ${widget.token}',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
