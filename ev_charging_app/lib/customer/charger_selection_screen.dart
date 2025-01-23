import 'package:flutter/material.dart';
import 'package:google_map_demo/customer/booking_screen.dart';

class ChargerSelectionScreen extends StatefulWidget {
  const ChargerSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ChargerSelectionScreen> createState() => _ChargerSelectionScreenState();
}

class _ChargerSelectionScreenState extends State<ChargerSelectionScreen> {
  int selectedIndex = 0;

  final List<Map<String, dynamic>> chargers = [
    {
      'name': 'Tesla P...',
      'type': 'AC/DC',
      'maxPower': '100 kW',
      'icon': Icons.ev_station,
    },
    {
      'name': 'Mennekes',
      'type': 'AC',
      'maxPower': '50 kW',
      'icon': Icons.electric_car,
    },
    {
      'name': 'CHAdeMO',
      'type': 'DC',
      'maxPower': '100 kW',
      'icon': Icons.electrical_services,
    },
    {
      'name': 'CCS1',
      'type': 'DC',
      'maxPower': '50 kW',
      'icon': Icons.charging_station,
    },
    {
      'name': 'CCS2',
      'type': 'DC',
      'maxPower': '50 kW',
      'icon': Icons.power,
    },
    {
      'name': 'J1772 (Type 1)',
      'type': 'AC',
      'maxPower': '50 kW',
      'icon': Icons.electric_bolt,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Select Charger',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chargers.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final charger = chargers[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            charger['icon'],
                            size: 24,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                charger['name'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    charger['type'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Max power',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    charger['maxPower'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Radio<int>(
                          value: index,
                          groupValue: selectedIndex,
                          activeColor: Colors.green,
                          onChanged: (value) {
                            setState(() {
                              selectedIndex = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return BookingScreen();
                    },
                  ),
                );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}