import 'package:flutter/material.dart';

/// Sample Bottom Navigation
/// Shows how to switch pages using BottomNavigationBar.
class SampleBottomNavigationScreen extends StatefulWidget {
  const SampleBottomNavigationScreen({super.key});

  @override
  State<SampleBottomNavigationScreen> createState() =>
      _SampleBottomNavigationScreenState();
}

class _SampleBottomNavigationScreenState
    extends State<SampleBottomNavigationScreen> {
  // Which tab is selected (0, 1, or 2)
  int _selectedIndex = 0;

  // Pages for each tab
  final List<Widget> _pages = const [
    Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),
    Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sample Bottom Navigation'),
      ),
      // Show the page based on selected tab
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          // Update selected tab when user taps
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
