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

  //late List<BarChartData> data;
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    // data = [
    //   BarChartData('CHN', 12),
    //   BarChartData('GER', 15),
    //   BarChartData('RUS', 30),
    //   BarChartData('BRZ', 6.4),
    //   BarChartData('IND', 14)
    // ];
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
                ? Colors.grey.withOpacity(0.5)
                : Colors.grey.withOpacity(0.3),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            title: Text(
              device.name,
              style: const TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              '${device.soFarConsumedEnergyInKwh} Kwh consumed ${device.isON ? '(Running)' : '(Off)'}',
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

  Widget _getUsage() {
    return Center(
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: ''),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 400,
          interval: 10,
          title: AxisTitle(text: 'Kwh'),
        ),
        series: <LineSeries<EnergyData, String>>[
          LineSeries<EnergyData, String>(
            // Bind data source
            dataSource: <EnergyData>[
              EnergyData('Jan', 120),
              EnergyData('Feb', 190),
              EnergyData('Mar', 200),
              EnergyData('Apr', 170),
              EnergyData('May', 250)
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
      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Appliances'),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: 100,
        interval: 10,
        title: AxisTitle(text: 'Kwh'),
      ),
      tooltipBehavior: _tooltip,
      series: <ChartSeries<Device, String>>[
        BarSeries<Device, String>(
          dataSource: _deviceList,
          xValueMapper: (Device data, _) => data.name,
          yValueMapper: (Device data, _) => data.soFarConsumedEnergyInKwh,
          name: '',
          color: const Color.fromRGBO(8, 142, 255, 1),
        )
      ],
    );
  }

  Widget _getSettings() {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.device_hub),
              label: const Text('Add New Applience'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete_forever),
              label: const Text('Remove Applience'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.reset_tv),
              label: const Text('Reset Applience'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15)),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.power_off),
              label: const Text('Shutdown all'),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15)),
            ),
          ],
        ),
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
        _getUsage(),
        _getDeviceUsage(),
        _getSettings(),
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
