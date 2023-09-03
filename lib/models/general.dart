class EnergyData {
  EnergyData(this.month, this.units);

  final String month;
  final double units;
}

class Device {
  String name;
  double soFarConsumedEnergyInKwh;
  bool isON;

  Device({
    required this.name,
    required this.soFarConsumedEnergyInKwh,
    required this.isON,
  });

  static List<Device> getDeviceList() {
    return [
      Device(
        name: 'Refrigerator',
        soFarConsumedEnergyInKwh: 42.23,
        isON: true,
      ),
      Device(
        name: 'Washing machine',
        soFarConsumedEnergyInKwh: 20.6,
        isON: true,
      ),
      Device(
        name: 'TV - Bedroom',
        soFarConsumedEnergyInKwh: 12.36,
        isON: true,
      ),
      Device(
        name: 'Light - Hall',
        soFarConsumedEnergyInKwh: 5.3,
        isON: true,
      ),
      Device(
        name: 'TV - Hall',
        soFarConsumedEnergyInKwh: 18.5,
        isON: false,
      ),
      Device(
        name: 'Light - Bedroom',
        soFarConsumedEnergyInKwh: 4.66,
        isON: false,
      ),
      Device(
        name: 'Air conditioner',
        soFarConsumedEnergyInKwh: 90.36,
        isON: true,
      ),
    ];
  }
}