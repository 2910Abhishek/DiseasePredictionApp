import 'package:flutter/material.dart';
import 'package:diseasepredictor/screens/symptoms.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiagonsisScreen extends StatefulWidget {
  DiagonsisScreen({Key? key, required this.selectedSymptoms}) : super(key: key);
  final List<Symptoms> selectedSymptoms;

  @override
  State<DiagonsisScreen> createState() {
    return _DiagonsisScreenState(selectedSymptoms);
  }
}

class _DiagonsisScreenState extends State<DiagonsisScreen> {
  _DiagonsisScreenState(this.selectedSymptoms);

  final List<Symptoms> selectedSymptoms;

  Future<void> submitSymptoms(List<int> selectedSymptoms) async {
    final url = Uri.parse('http://127.0.0.1:5000/predict');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'selected_symptoms': selectedSymptoms}),
    );
    if (response.statusCode == 200) {
      // Handle successful response, e.g., display prediction result
      print('Prediction Result: ${json.decode(response.body)['prediction']}');
    } else {
      // Handle error response
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> symptomNames = widget.selectedSymptoms.map((symptom) {
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
            Text('You Might have a cold', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: formattedSymptoms,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () {
            List<int> symptomVector =
                List.filled(131, 0); // Initialize with zeros
            selectedSymptoms.forEach((symptom) {
              print(symptom);
              symptomVector[symptom.index] =
                  1; // Set selected symptom positions to 1
            });
            print(symptomVector);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    DiagonsisScreen(selectedSymptoms: selectedSymptoms),
              ),
            );
          },
          child: const Center(
            child: Text('Talk to a doctor now'),
          ),
        ),
      ),
    );
  }
}
