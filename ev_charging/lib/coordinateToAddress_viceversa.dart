import 'dart:developer';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';

class CoordinatetoaddressViceversa extends StatefulWidget {
  const CoordinatetoaddressViceversa({super.key});

  @override
  State<CoordinatetoaddressViceversa> createState() =>
      _CoordinatetoaddressViceversaState();
}

class _CoordinatetoaddressViceversaState
    extends State<CoordinatetoaddressViceversa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                // Convert address to coordinates
                List<Location> locations =
                    await locationFromAddress("nanded city");
                double latitude = locations.first.latitude;
                double longitude = locations.first.longitude;
                log("Longitude: $longitude, Latitude: $latitude");
              } catch (e) {
                log("Error converting address to coordinates: $e");
              }
            },
            child: const Text("Address to Coordinates nanded city"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                // Convert coordinates to address
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    18.4529322, 73.86523799999999);
                Placemark place = placemarks.first;
                log("Address: ${place.street}, ${place.locality}, ${place.country}");
                log("Latitude: 18.4576826, Longitude: 73.8643567");
              } catch (e) {
                log("Error converting coordinates to address: $e");
              }
            },
            child: const Text("Coordinates to Address"),
          ),
        ],
      ),
    );
  }
}
