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

  final List<Marker> myMarker = [];
  final List<Marker> markerList = const [
    Marker(
      markerId: MarkerId('First'),
      position: LatLng(22.310986373136316, 73.18424423879603),
      infoWindow: InfoWindow(
        title: 'My Position',
      ),
    ),
    Marker(
      markerId: MarkerId('Second'),
      position: LatLng(22.325433459682962, 73.24443967805671),
      infoWindow: InfoWindow(
        title: 'D Mart',
      ),
    ),
    Marker(
      markerId: MarkerId('Third'),
      position: LatLng(22.25733400245275, 73.19924982521647),
      infoWindow: InfoWindow(
        title: 'Tarshali Sussen Circle',
      ),
    ),
    Marker(
      markerId: MarkerId('Fourth'),
      position: LatLng(22.59906328385306, 72.81768950736505),
      infoWindow: InfoWindow(
        title: 'Charusat',
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _initialPosition,
          mapType: MapType.normal,
          markers: Set<Marker>.of(myMarker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_searching),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(22.59906328385306, 72.81768950736505),
                zoom: 14,
              ),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}
