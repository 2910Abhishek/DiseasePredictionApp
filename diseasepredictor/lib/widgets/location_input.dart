import 'dart:convert';

import 'package:diseasepredictor/models/place.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationInput extends StatefulWidget {
  LocationInput({super.key});

  @override
  State<LocationInput> createState() {
    return _LocationInputState();
  }
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? _pickedLocation;
  var _isGettingLocation = false;

  String get locationImage {
    if (_pickedLocation == null) {
      return '';
    }

    final lat = _pickedLocation!.latitude;
    final lng = _pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng,NY&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCsI-6XzDxP4QCAod33iU2Hme-MMuZ--ho';
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      _isGettingLocation = true;
    });

    try {
      _locationData = await location.getLocation();

      final lat = _locationData.latitude;
      final lng = _locationData.longitude;

      if (lat == null || lng == null) {
        setState(() {
          _isGettingLocation = false;
        });
        return;
      }

      final url = Uri.parse(
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=AIzaSyCsI-6XzDxP4QCAod33iU2Hme-MMuZ--ho');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final resdata = json.decode(response.body);
        if (resdata['results'] != null && resdata['results'].isNotEmpty) {
          final address = resdata['results'][0]['formatted_address'];

          setState(() {
            _pickedLocation =
                PlaceLocation(latitude: lat, longitude: lng, address: address);
            _isGettingLocation = false;
          });
        } else {
          print("No results found in the geocoding response.");
          setState(() {
            _isGettingLocation = false;
          });
        }
      } else {
        print("Error getting location data: ${response.statusCode}");
        setState(() {
          _isGettingLocation = false;
        });
      }
    } catch (error) {
      print("Error getting location: $error");
      setState(() {
        _isGettingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'No Location Chosen',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onBackground,
          ),
    );

    if (_pickedLocation != null) {
      previewContent = Image.network(locationImage,
          fit: BoxFit.cover, width: double.infinity, height: double.infinity);
    }

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }

    return Column(
      children: [
        Center(
          child: Container(
            alignment: Alignment.center,
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              ),
            ),
            child: previewContent,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: Text('Get Current Location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: Text('Select on Map')),
          ],
        ),
      ],
    );
  }
}
