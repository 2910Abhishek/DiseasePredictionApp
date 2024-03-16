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
    setState(() {
      _profileImageUrl = url;
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
                        : AssetImage('assests/images/default_image.png')
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
                    onPressed: () {
                      // Navigate to history screen or perform any action
                    },
                    child: Text('History'),
                  ),
                ],
              ),
            ),
    );
  }
}
