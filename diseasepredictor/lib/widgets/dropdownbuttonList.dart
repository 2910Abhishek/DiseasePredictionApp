import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:diseasepredictor/screens/symptoms.dart';
import 'package:http/http.dart' as http;

class DropdownButtonList extends StatefulWidget {
  final List<Symptoms> savedSymptoms;

  DropdownButtonList({Key? key, required this.savedSymptoms}) : super(key: key);

  @override
  State<DropdownButtonList> createState() =>
      _DropdownButtonListState(savedSymptoms);
}

class _DropdownButtonListState extends State<DropdownButtonList> {
  final List<Symptoms> savedSymptoms;

  _DropdownButtonListState(this.savedSymptoms);

  late Symptoms? _selectedSymptoms;

  @override
  void initState() {
    super.initState();
    _selectedSymptoms = null; // Initialize with null to show alias
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
        ),
        child: DropdownButton<Symptoms>(
          isExpanded: true,
          focusColor: const Color.fromARGB(255, 84, 188, 87),
          value: _selectedSymptoms,
          items: [
            DropdownMenuItem<Symptoms>(
              value: null,
              child: Text('Select a symptom'), // Alias name
            ),
            ...Symptoms.values
                .map(
                  (symptom) => DropdownMenuItem<Symptoms>(
                    value: symptom,
                    child: Text(
                      symptom.name,
                    ),
                  ),
                )
                .toList(),
          ],
          onChanged: (Symptoms? value) {
            setState(() {
              _selectedSymptoms = value;
              if (value != null) {
                savedSymptoms.add(value);
                // Add the selected symptom to the list
              }
            });
          },
        ),
      ),
    );
  }
}
