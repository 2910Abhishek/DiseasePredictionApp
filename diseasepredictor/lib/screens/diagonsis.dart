import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:diseasepredictor/screens/symptoms.dart';

class DiagonsisScreen extends StatefulWidget {
  DiagonsisScreen(
      {Key? key, required this.selectedSymptoms, required this.symptomVector})
      : super(key: key);
  final List<Symptoms> selectedSymptoms;
  final List<int> symptomVector;

  @override
  State<DiagonsisScreen> createState() {
    return _DiagonsisScreenState(selectedSymptoms, symptomVector);
  }
}

class _DiagonsisScreenState extends State<DiagonsisScreen> {
  final List<Symptoms> selectedSymptoms;
  final List<int> symptomVector;
  String result = '';

  _DiagonsisScreenState(this.selectedSymptoms, this.symptomVector);

  Future<void> submitSymptoms(List<int> selectedSymptoms) async {
    final url = Uri.parse('http://127.0.0.1:5000/prediction');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'selected_symptoms': symptomVector}),
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
            Text('You Might have a $result', style: TextStyle(fontSize: 20)),
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

          try {
            final url = Uri.parse('http://127.0.0.1:5000/prediction');
            final response = await http.post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({'selected_symptoms': symptomVector}),
            );

            print('Response Status Code: ${response.statusCode}');
            print('Response Body: ${response.body}');

            if (response.statusCode == 200) {
              final Map<String, dynamic> responseData =
                  json.decode(response.body);
              setState(() {
                result = responseData['prediction'];
              });
            } else {
              print('Error: ${response.reasonPhrase}');
            }
          } catch (e) {
            print('Error: $e');
          }
        },
        child: Icon(Icons.chat),
      ),
    );
  }
}
