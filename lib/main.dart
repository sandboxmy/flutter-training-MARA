import 'package:flutter/material.dart';
import 'package:flutter_training_mara/sample_navigation.dart';

import 'sample_bottom_navigation.dart';
import 'sample_button.dart';
import 'sample_column.dart';
import 'sample_container_widget.dart';
import 'sample_grid_tile.dart';
import 'sample_icon.dart';
import 'sample_list_tile.dart';
import 'sample_row.dart';
import 'sample_stack.dart';
import 'sample_stateful_widget.dart';
import 'sample_stateless_widget.dart';
import 'sample_text_widget.dart';
import 'sample_wrap.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Home screen
      home: const HomePage(),

      // Named routes
      routes: {
        SampleNavigationScreen.routeName: (context) =>
            const SampleNavigationScreen(),
        DetailByNamedRouteScreen.routeName: (context) =>
            const DetailByNamedRouteScreen(),
      },
    );
  }
}

/// Home screen - list of all sample screens for students
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Each item: title + screen to open
  static final List<Map<String, dynamic>> samples = [
    {'title': 'Button', 'screen': const SampleButtonScreen()},
    {
      'title': 'Bottom Navigation',
      'screen': const SampleBottomNavigationScreen(),
    },
    {'title': 'ListTile (Vertical)', 'screen': const SampleListTileScreen()},
    {'title': 'GridTile', 'screen': const SampleGridTileScreen()},
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Samples')),
      body: ListView.builder(
        itemCount: samples.length,
        itemBuilder: (context, index) {
          final sample = samples[index];
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(sample['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Open the selected sample screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => sample['screen'] as Widget,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
