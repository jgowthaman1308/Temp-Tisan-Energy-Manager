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
  final List<Device> _deviceList = Device.getDeviceList();

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget _getNow() {
    return ListView.builder(
      itemCount: _deviceList.length,
      itemBuilder: (context, index) {
        final device = _deviceList[index];
        return Container(
          margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
          decoration: BoxDecoration(
            color: (device.isON)
                ? Colors.grey.withOpacity(0.8)
                : Colors.grey.withOpacity(0.4),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            title: Text(
              device.name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              '${device.soFarConsumedEnergyInKwh} Kwh consumed',
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            trailing: Switch(
              value: _deviceList[index].isON,
              onChanged: (value) {
                setState(() {
                  _deviceList[index].isON = value;
                });
              },
            ),
          ),
        );
      },
    );
  }

  Widget _getHome() {
    return Center(
      child: SfCartesianChart(
        // Initialize category axis
        primaryXAxis: CategoryAxis(),
        series: <LineSeries<EnergyData, String>>[
          LineSeries<EnergyData, String>(
            // Bind data source
            dataSource: <EnergyData>[
              EnergyData('Jan', 35),
              EnergyData('Feb', 28),
              EnergyData('Mar', 34),
              EnergyData('Apr', 32),
              EnergyData('May', 40)
            ],
            xValueMapper: (EnergyData sales, _) => sales.month,
            yValueMapper: (EnergyData sales, _) => sales.units,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Energy Manager'),
        centerTitle: true,
        elevation: 1,
      ),
      body: [
        _getNow(),
        _getHome(),
        const Center(child: Text('Search')),
        const Center(child: Text('Profile')),
      ].elementAt(_currentIndex), // Show the page according to the index
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          // Define the items for the bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Usage',
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
