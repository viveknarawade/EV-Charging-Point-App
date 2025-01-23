import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _position = const CameraPosition(
    target: LatLng(18.520430, 73.856743),
    zoom: 15, // Increased zoom level to match screenshot
  );

  @override
  void initState() {
    super.initState();
    _markers.addAll(_list);
  }

  final Set<Marker> _markers = {};
  final List<Marker> _list = [
    // Green markers
    Marker(
      markerId: const MarkerId('1'),
      position: const LatLng(18.520430, 73.856743),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    Marker(
      markerId: const MarkerId('2'),
      position: const LatLng(18.515430, 73.851743),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    ),
    // Red markers
    Marker(
      markerId: const MarkerId('3'),
      position: const LatLng(18.525430, 73.861743),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
    Marker(
      markerId: const MarkerId('4'),
      position: const LatLng(18.510430, 73.846743),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        initialCameraPosition: _position,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}