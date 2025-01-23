import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart' as loc; // Add alias for location package

class RouteScreen extends StatefulWidget {
  const RouteScreen({super.key});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Map<PolylineId, Polyline> polylines = {};
  final TextEditingController _endAddressController = TextEditingController();

  final CameraPosition _position = const CameraPosition(
    target: LatLng(18.467747, 73.830505), // Default position
    zoom: 15,
  );

  List<Marker> _markers = [];
  loc.Location _location = loc.Location(); // Use the alias here
  loc.LocationData? _currentLocation; // Use the alias here

  @override
  void initState() {
    super.initState();
    _location.requestPermission();
    _location.onLocationChanged.listen((loc.LocationData currentLocation) { // Use the alias here
      setState(() {
        _currentLocation = currentLocation;
      });
      if (_currentLocation != null) {
        _updateRouteWithCurrentLocation();
      }
    });
  }

  Future<LatLng> _getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      double latitude = locations.first.latitude;
      double longitude = locations.first.longitude;
      log("Longitude: $longitude, Latitude: $latitude");
      return LatLng(latitude, longitude);
    } catch (e) {
      log("Error converting address to coordinates: $e");
      return LatLng(0, 0); // Return a default value for errors
    }
  }

  Future<void> _drawRouteUsingOSRM(LatLng start, LatLng end) async {
    final url =
        "https://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=polyline";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final String polyline = data['routes'][0]['geometry'];
        final List<LatLng> polylinePoints = _decodePolyline(polyline);

        final PolylineId polylineId = PolylineId("osrm_route");
        final Polyline routePolyline = Polyline(
          polylineId: polylineId,
          color: Colors.blue,
          width: 5,
          points: polylinePoints,
        );

        setState(() {
          polylines[polylineId] = routePolyline;
        });

        // Adjust camera to fit the route
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(
          CameraUpdate.newLatLngBounds(
            _getLatLngBounds(polylinePoints),
            50, // Padding for the bounds
          ),
        );
      } else {
        log("Failed to fetch route: ${response.body}");
      }
    } catch (e) {
      log("Error fetching route: $e");
    }
  }

  LatLngBounds _getLatLngBounds(List<LatLng> points) {
    double south = points.first.latitude;
    double north = points.first.latitude;
    double west = points.first.longitude;
    double east = points.first.longitude;

    for (var point in points) {
      if (point.latitude < south) south = point.latitude;
      if (point.latitude > north) north = point.latitude;
      if (point.longitude < west) west = point.longitude;
      if (point.longitude > east) east = point.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(south, west),
      northeast: LatLng(north, east),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int shift = 0, result = 0;
      int byte;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        byte = encoded.codeUnitAt(index++) - 63;
        result |= (byte & 0x1F) << shift;
        shift += 5;
      } while (byte >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  Future<void> _handleDrawRoute() async {
    final endAddress = _endAddressController.text;

    if (endAddress.isNotEmpty && _currentLocation != null) {
      final startCoordinates = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
      final endCoordinates = await _getCoordinatesFromAddress(endAddress);

      if (endCoordinates != LatLng(0, 0)) {
        // Add markers for the start and end locations
        setState(() {
          _markers = [
            Marker(
              markerId: const MarkerId("start"),
              position: startCoordinates,
              infoWindow: InfoWindow(title: "Start: Current Location"),
            ),
            Marker(
              markerId: const MarkerId("end"),
              position: endCoordinates,
              infoWindow: InfoWindow(title: "End: $endAddress"),
            ),
          ];
        });

        // Adjust the camera to the start location
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newLatLngZoom(startCoordinates, 15));

        // Draw the route using OSRM
        _drawRouteUsingOSRM(startCoordinates, endCoordinates);
      }
    } else {
      print("Please enter the destination address or wait for location.");
    }
  }

  void _updateRouteWithCurrentLocation() {
    if (_currentLocation != null) {
      final currentLatLng = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);
      final endAddress = _endAddressController.text;

      if (endAddress.isNotEmpty) {
        _getCoordinatesFromAddress(endAddress).then((endCoordinates) {
          if (endCoordinates != LatLng(0, 0)) {
            _drawRouteUsingOSRM(currentLatLng, endCoordinates);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Finder'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _endAddressController,
              decoration: const InputDecoration(
                hintText: "Enter destination address",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _handleDrawRoute,
            child: const Text("Draw Route"),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              initialCameraPosition: _position,
              markers: Set<Marker>.of(_markers),
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
