import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BGNUMapScreen extends StatelessWidget {
  final LatLng bgnuLocation = LatLng(31.49414, 73.72249); // Adampura, Nankana Sahib

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Baba Guru Nanak University')),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: bgnuLocation,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId('bgnu'),
            position: bgnuLocation,
            infoWindow: InfoWindow(title: 'Baba Guru Nanak University'),
          ),
        },
      ),
    );
  }
}
