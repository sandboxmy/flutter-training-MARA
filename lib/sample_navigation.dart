import 'package:flutter/material.dart';

/// Sample Navigation
/// Shows students how to:
/// 1. Pass data with Navigator.push (constructor)
/// 2. Pass data with named routes
/// 3. Get data back from the next screen
class SampleNavigationScreen extends StatelessWidget {
  const SampleNavigationScreen({super.key});

  // Route name for this screen (used in MaterialApp routes)
  static const String routeName = '/sample-navigation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Navigation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose a navigation example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // ---------- METHOD 1 ----------
            ElevatedButton(
              onPressed: () {
                // Pass data using constructor
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailByConstructorScreen(
                      name: 'Ali',
                      age: 20,
                    ),
                  ),
                );
              },
              child: const Text('1. Pass data (constructor)'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Navigator.push + pass values into the next screen constructor',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // ---------- METHOD 2 ----------
            ElevatedButton(
              onPressed: () {
                // Pass data using named route + arguments
                Navigator.pushNamed(
                  context,
                  DetailByNamedRouteScreen.routeName,
                  arguments: {
                    'name': 'Siti',
                    'age': 22,
                  },
                );
              },
              child: const Text('2. Pass data (named route)'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Navigator.pushNamed + arguments map',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // ---------- METHOD 3 ----------
            ElevatedButton(
              onPressed: () async {
                // Open next screen and WAIT for a result
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectItemScreen(),
                  ),
                );

                // Show the returned value
                if (context.mounted && result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('You selected: $result')),
                  );
                }
              },
              child: const Text('3. Get data back from next screen'),
            ),
            const SizedBox(height: 8),
            const Text(
              'Navigator.pop(context, value) returns data to previous screen',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

/// METHOD 1: Receive data from constructor
class DetailByConstructorScreen extends StatelessWidget {
  const DetailByConstructorScreen({
    super.key,
    required this.name,
    required this.age,
  });

  final String name;
  final int age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail (Constructor)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name', style: const TextStyle(fontSize: 24)),
            Text('Age: $age', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // go back
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

/// METHOD 2: Receive data from named route arguments
class DetailByNamedRouteScreen extends StatelessWidget {
  const DetailByNamedRouteScreen({super.key});

  static const String routeName = '/detail-named';

  @override
  Widget build(BuildContext context) {
    // Read the arguments sent by pushNamed
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final name = args['name'] as String;
    final age = args['age'] as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail (Named Route)'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: $name', style: const TextStyle(fontSize: 24)),
            Text('Age: $age', style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}

/// METHOD 3: Select something and return it to previous screen
class SelectItemScreen extends StatelessWidget {
  const SelectItemScreen({super.key});

  static const List<String> items = ['Apple', 'Banana', 'Orange'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select an Item'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
            onTap: () {
              // Return selected item to previous screen
              Navigator.pop(context, items[index]);
            },
          );
        },
      ),
    );
  }
}
