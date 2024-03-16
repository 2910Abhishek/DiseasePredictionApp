import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DiagonsisScreen extends StatefulWidget {
  DiagonsisScreen({
    Key? key,
    required this.selectedSymptoms,
    required this.result,
  }) : super(key: key);

  final List<String> selectedSymptoms;
  final String result;

  @override
  State<DiagonsisScreen> createState() => _DiagonsisScreenState();
}

class _DiagonsisScreenState extends State<DiagonsisScreen> {
  @override
  void initState() {
    super.initState();
    _saveResultToFirestore();
  }

  Future<void> _saveResultToFirestore() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final CollectionReference userRef =
            FirebaseFirestore.instance.collection('users');

        // Add the diagnosis to the 'previous_diseases' subcollection
        await userRef.doc(user.uid).collection('previous_diseases').add({
          'disease_name': widget.result,
          'diagnosis_date': DateTime.now(),
        });

        print('Diagnosis result saved to Firestore.');
      } else {
        print('User not logged in.');
      }
    } catch (error) {
      print('Error saving diagnosis result: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Selected Symptoms: ${widget.selectedSymptoms}'); // Debug print

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
          children: [
            Text(
              'Based on your symptoms, here\'s what we found',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 20),
            Text(
              'You Might have a ${widget.result}',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Selected Symptoms:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.selectedSymptoms.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      widget.selectedSymptoms[index],
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
