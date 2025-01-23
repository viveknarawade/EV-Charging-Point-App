import 'package:flutter/material.dart';

class CustomerHomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> locations = [
    {
      'name': 'ImPark Underhill Garage',
      'address': 'Brooklyn, 155 Underhill Ave',
      'isAvailable': true
    },
    {
      'name': '99 Prospect Park W',
      'address': 'Brooklyn, 99 Prospect Park W',
      'isAvailable': false
    },
    {
      'name': 'ImPark Underhill Garage',
      'address': 'Brooklyn, 155 Underhill Ave',
      'isAvailable': true
    },
    {
      'name': '99 Prospect Park W',
      'address': 'Brooklyn, 99 Prospect Park W',
      'isAvailable': false
    },
    {
      'name': 'ImPark Underhill Garage',
      'address': 'Brooklyn, 155 Underhill Ave',
      'isAvailable': true
    },
    {
      'name': '99 Prospect Park W',
      'address': 'Brooklyn, 99 Prospect Park W',
      'isAvailable': false
    },
    {
      'name': 'ImPark Underhill Garage',
      'address': 'Brooklyn, 155 Underhill Ave',
      'isAvailable': true
    },
    {
      'name': '99 Prospect Park W',
      'address': 'Brooklyn, 99 Prospect Park W',
      'isAvailable': false
    },
    // Add other locations similarly
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: Icon(Icons.tune),
                  hintText: 'Search station',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return GestureDetector(
                    onTap: () {
                      
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.local_parking,
                        color:
                            location['isAvailable'] ? Colors.green : Colors.red,
                      ),
                      title: Text(location['name']),
                      subtitle: Text(location['address']),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {},
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
