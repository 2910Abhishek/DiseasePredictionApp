import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User? _currentUser;
  late String _username = '';
  late String _email = '';
  late String _profileImageUrl = '';
  List<PreviousDisease> _previousDiseases = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });
      final userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();
      setState(() {
        _username = userData['username'];
        _email = userData['email'];
      });
      _fetchProfileImage();
    }
  }

  Future<void> _fetchProfileImage() async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_Image')
        .child('${_currentUser!.uid}.jpg');
    final url = await ref.getDownloadURL();
    print("Profile Image URL: $url"); // Debug print statement
    setState(() {
      _profileImageUrl = url;
    });
  }

  Future<void> _fetchPreviousDiseases() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(_currentUser!.uid)
        .collection('previous_diseases')
        .orderBy('diagnosis_date', descending: true)
        .get();

    setState(() {
      _previousDiseases = snapshot.docs.map((doc) {
        return PreviousDisease(
          diseaseName: doc['disease_name'],
          diagnosisDate: doc['diagnosis_date'].toDate(),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentUser == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(top: 15, bottom: 10)),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: _profileImageUrl.isNotEmpty
                        ? NetworkImage(_profileImageUrl)
                        : AssetImage('assets/images/default_image.png')
                            as ImageProvider,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Username: $_username',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'Email: $_email',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      await _fetchPreviousDiseases();
                      _showPreviousDiseasesDialog(context);
                    },
                    child: Text('History'),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _showPreviousDiseasesDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Previous Diseases'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: ListView(
              children: _previousDiseases.map((disease) {
                return ListTile(
                  title: Text(disease.diseaseName),
                  subtitle: Text('Diagnosis Date: ${disease.diagnosisDate}'),
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class PreviousDisease {
  final String diseaseName;
  final DateTime diagnosisDate;

  PreviousDisease({
    required this.diseaseName,
    required this.diagnosisDate,
  });
}
