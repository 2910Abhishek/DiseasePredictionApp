import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
        title: 'Initial Location',
      ),
    ),
    Marker(
      markerId: MarkerId('Second'),
      position: LatLng(22.602946462589316, 72.82155965660046),
      infoWindow: InfoWindow(
        title: 'Charusat Hospital',
      ),
    ),
    Marker(
      markerId: MarkerId('Third'),
      position: LatLng(22.621235613648143, 72.98698957578023),
      infoWindow: InfoWindow(
        title: 'Charusat Hospital',
      ),
    ),
    Marker(
      markerId: MarkerId('Fourth'),
      position: LatLng(23.028350041456186, 72.62282931823461),
      infoWindow: InfoWindow(
        title: 'Narayana Hospital, Ahmedabad',
      ),
    ),
    Marker(
      markerId: MarkerId('Fifth'),
      position: LatLng(23.00812683920746, 72.6087530858764),
      infoWindow: InfoWindow(
        title: 'Siddhi Vinayak Hospital',
      ),
    ),
    Marker(
      markerId: MarkerId('Fifth'),
      position: LatLng(22.997971370892646, 72.61630592213353),
      infoWindow: InfoWindow(
        title: 'Pramukh Multi-speciality Hospital',
      ),
    ),
    Marker(
      markerId: MarkerId('Sixth'),
      position: LatLng(22.317187965240237, 73.15782822879008),
      infoWindow: InfoWindow(
        title: 'Sterling Hospitals - Vadodara',
      ),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myMarker.addAll(markerList);
    //packData();
  }

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('Error $error');
    });

    return await Geolocator.getCurrentPosition();
  }

  packData() {
    getUserLocation().then((value) async {
      print('My Location');
      print('${value.latitude} ${value.longitude}');

      myMarker.add(
        Marker(
          markerId: const MarkerId('Second'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(
            title: 'My Location',
          ),
        ),
      );
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;

      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    });
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
          // GoogleMapController controller = await _controller.future;
          // controller.animateCamera(
          //   CameraUpdate.newCameraPosition(
          //     const CameraPosition(
          //       target: LatLng(22.59906328385306, 72.81768950736505),
          //       zoom: 14,
          //     ),
          //   ),
          // );
          packData();
          setState(() {});
        },
      ),
    );
  }
}
