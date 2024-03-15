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
