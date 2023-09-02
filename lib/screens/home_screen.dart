import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the index of the currently selected item
  int _currentIndex = 0;

  // Define the list of pages to show according to the selected item
  final List<Widget> _pages = [
    const Center(child: Text('Home')),
    const Center(child: Text('Search')),
    const Center(child: Text('Profile')),
  ];

  // Define the function to handle user taps on the items
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bottom Navigation Bar Example'),
      ),
      body: _pages[_currentIndex], // Show the page according to the index
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          // Define the items for the bottom navigation bar
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
        currentIndex: _currentIndex, // Highlight the selected item
        onTap: _onItemTapped, // Handle user taps on the items
      ),
    );
  }
}
