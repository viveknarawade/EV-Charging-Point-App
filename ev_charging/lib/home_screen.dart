import 'package:flutter/material.dart';
import 'package:google_map_demo/customer/customer_home_screen.dart';
import 'package:google_map_demo/customer/vehicle_selection_screen.dart';
import 'package:google_map_demo/customer/view_detail_screen.dart';
import 'package:google_map_demo/display_map.dart';

import 'route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/p1.png"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return CustomerHomeScreen();
                  },
                ),
              );
            },
            child: Text("Home"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ),
              );
            },
            child: Text("map"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ViewDetailScreen();
                  },
                ),
              );
            },
            child: Text("View details screen"),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
