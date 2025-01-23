import 'package:flutter/material.dart';
import 'package:google_map_demo/customer/charger_selection_screen.dart';

class Vehicle {
  final String brand;
  final String model;
  final String variant;
  final Color color;
  final bool isSelected;

  Vehicle({
    required this.brand,
    required this.model,
    required this.variant,
    required this.color,
    this.isSelected = false,
  });
}

class VehicleSelectionScreen extends StatefulWidget {
  @override
  _VehicleSelectionScreenState createState() => _VehicleSelectionScreenState();
}

class _VehicleSelectionScreenState extends State<VehicleSelectionScreen> {
  int? selectedIndex;
  final vehicles = [
    Vehicle(brand: 'Tesla', model: 'S', variant: '4D', color: Colors.red),
    Vehicle(
        brand: 'Audi',
        model: 'e-tron',
        variant: 'Prestige',
        color: Colors.blue),
    Vehicle(
        brand: 'Porsche',
        model: 'Taycan',
        variant: 'Turbo S',
        color: Colors.grey),
    Vehicle(
        brand: 'Ford',
        model: 'Mustang Mach-E',
        variant: 'GT',
        color: Colors.amber),
    Vehicle(
        brand: 'Volkswagen',
        model: 'ID.4',
        variant: '1st Edition',
        color: Colors.indigo),
    Vehicle(
        brand: 'Kia',
        model: 'Niro EV',
        variant: 'EX Premium',
        color: Colors.grey),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text('Select Your Vehicle'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: vehicles.length,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            color: vehicle.color,
                            size: 32,
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  vehicle.brand,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '${vehicle.model} • ${vehicle.variant}',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Radio<int>(
                            value: index,
                            groupValue: selectedIndex,
                            onChanged: (value) =>
                                setState(() => selectedIndex = value),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                selectedIndex != null ? () {} : null;

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChargerSelectionScreen();
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
