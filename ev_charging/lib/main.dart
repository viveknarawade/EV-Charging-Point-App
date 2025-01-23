import 'package:flutter/material.dart';
import 'package:google_map_demo/coordinateToAddress_viceversa.dart';
import 'package:google_map_demo/display_map.dart';
import 'package:google_map_demo/home_screen.dart';

import 'route.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Center(child: Text('An error occurred!'));
  };
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
