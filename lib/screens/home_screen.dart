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

  late List<BarChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    data = [
      BarChartData('CHN', 12),
      BarChartData('GER', 15),
      BarChartData('RUS', 30),
      BarChartData('BRZ', 6.4),
      BarChartData('IND', 14)
    ];
    _tooltip = TooltipBehavior(enable: true);
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
      padding: const EdgeInsets.only(bottom: 50),
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

  Widget _getDeviceUsage() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<BarChartData, String>>[
        BarSeries<BarChartData, String>(
          dataSource: data,
          xValueMapper: (BarChartData data, _) => data.x,
          yValueMapper: (BarChartData data, _) => data.y,
          name: 'Gold',
          color: const Color.fromRGBO(8, 142, 255, 1),
        )
      ],
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
        _getDeviceUsage(),
        const Center(child: Text('Profile')),
      ].elementAt(_currentIndex), // Show the page according to the index
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        items: const [
          // Define the items for the bottom navigation bar
          BottomNavigationBarItem(
            icon: Icon(Icons.equalizer),
            label: 'Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.data_usage),
            label: 'Usage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'devices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _currentIndex, // Highlight the selected item
        onTap: _onItemTapped, // Handle user taps on the items
      ),
    );
  }
}
