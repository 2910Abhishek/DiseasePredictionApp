import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  State<Maps> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<Maps> {
  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _initialPosition = CameraPosition(
    target: LatLng(22.310986373136316, 73.18424423879603),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
