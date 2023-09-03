import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/general.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define the index of the currently selected item
  int _currentIndex = 0;

  // Define the list of pages to show according to the selected item
  List<Widget> _pages = [];

  @override
  void initState() {
    _pages = [
      _getHome(),
      const Center(child: Text('Search')),
      const Center(child: Text('Profile')),
    ];

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getHome() {
    return Center(
      child: Container(
        child: SfCartesianChart(
          // Initialize category axis
          primaryXAxis: CategoryAxis(),
          series: <LineSeries<SalesData, String>>[
            LineSeries<SalesData, String>(
                // Bind data source
                dataSource: <SalesData>[
                  SalesData('Jan', 35),
                  SalesData('Feb', 28),
                  SalesData('Mar', 34),
                  SalesData('Apr', 32),
                  SalesData('May', 40)
                ],
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales)
          ],
        ),
      ),
    );
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
