import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:diseasepredictor/screens/symptoms.dart';

class DiagonsisScreen extends StatefulWidget {
  DiagonsisScreen(
      {Key? key, required this.selectedSymptoms, required this.result})
      : super(key: key);
  final List<Symptoms> selectedSymptoms;
  final String result;

  @override
  State<DiagonsisScreen> createState() {
    return _DiagonsisScreenState(selectedSymptoms, result);
  }
}

class _DiagonsisScreenState extends State<DiagonsisScreen> {
  final List<Symptoms> selectedSymptoms;
  final String result;

  _DiagonsisScreenState(this.selectedSymptoms, this.result);

  @override
  Widget build(BuildContext context) {
    List<String> symptomNames = selectedSymptoms.map((symptom) {
      String symptomString = symptom.toString();
      return symptomString.substring(
          symptomString.indexOf('.') + 1); // Extracting substring after the dot
    }).toList();

    List<Widget> formattedSymptoms = [];
    for (var i = 0; i < symptomNames.length; i++) {
      formattedSymptoms.add(
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(symptomNames[i]),
        ),
      );
      if (i != symptomNames.length - 1) {
        formattedSymptoms.add(SizedBox(height: 10));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Diagnosis',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Based on your symptoms, here\'s what we found',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text('You Might have a ${result.toString()}',
                style: TextStyle(fontSize: 20, color: Colors.white)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formattedSymptoms,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          List<int> symptomVector = List.filled(131, 0);
          selectedSymptoms.forEach((symptom) {
            symptomVector[symptom.index] = 1;
          });
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
