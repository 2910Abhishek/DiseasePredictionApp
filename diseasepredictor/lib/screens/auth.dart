import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diseasepredictor/screens/tabs.dart';
import 'package:diseasepredictor/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final _form = GlobalKey<FormState>();

  var _islogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';
  File? _selectedImage;
  var _isAuthenticating = false;
  var _enteredUsername = '';

  Future<void> _showErrorDialog(String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('An Error Occurred'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!_islogin && _selectedImage == null) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });

    try {
      if (_islogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabScreen()),
        );
        // Handle successful login
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );
        // Handle successful sign up
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_Image')
            .child('${userCredential.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!);

        final imageurl = await storageRef.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': _enteredUsername,
          'email': _enteredEmail,
          'image_url': imageurl,
        });
        // Set _isAuthenticating to false after successful sign up
        setState(() {
          _isAuthenticating = false;
        });
      }
    } on FirebaseAuthException catch (error) {
      // Handle authentication errors
      String errorMessage = 'Authentication failed';
      if (error.code == 'wrong-password') {
        errorMessage = 'Invalid password';
      } else if (error.code == 'user-not-found') {
        errorMessage = 'No user found for that email';
      } else if (error.code == 'email-already-in-use') {
        errorMessage = 'Email is already in use';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      // Handle other errors
      print('Error: $error');
      _showErrorDialog('An error occurred. Please try again later.');
    } finally {
      // Set _isAuthenticating to false after the authentication process is complete
      setState(() {
        _isAuthenticating = false;
      });
      if (!_islogin) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome To Healthie!'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15), // Add padding above the text
            Text(
              'Sign in to your account',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Add spacing between text and form fields
            Padding(
              padding: const EdgeInsets.all(
                  20.0), // Add padding around the Card widget
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(
                      16.0), // Add padding inside the Card widget
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (!_islogin)
                          Center(child:
                              UserImagePicker(onPickImage: (pickedimage) {
                            _selectedImage = pickedimage;
                          })),
                        Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            hintText: 'Your Email',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredEmail = value!;
                          },
                        ),
                        SizedBox(height: 10),
                        if (!_islogin)
                          Container(
                            // margin: EdgeInsets.only(
                            //     top: 20), // Add some space between fields
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Username',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        value.trim().length < 4) {
                                      return 'Please enter at least 4 characters';
                                    }
                                    return null;
                                  },
                                  decoration:
                                      InputDecoration(labelText: 'Username'),
                                  enableSuggestions: false,
                                  onSaved: (value) {
                                    _enteredUsername = value!;
                                  },
                                ),
                              ],
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Your Password',
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be at least 6 characters long.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredPassword = value!;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between the Card and buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Visibility(
                visible: !_isAuthenticating,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(188, 0, 0, 0),
                      foregroundColor: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _islogin ? 'Login' : 'Sign Up',
                      ),
                    ),
                  ),
                ),
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),

            SizedBox(height: 10), // Add spacing between buttons

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Visibility(
                visible: !_isAuthenticating,
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(155, 0, 0, 0),
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _islogin = !_islogin;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        _islogin
                            ? 'Create an account'
                            : 'I already have an account',
                      ),
                    ),
                  ),
                ),
                replacement: const SizedBox
                    .shrink(), // Hide the button when authenticating
              ),
            ),
          ],
        ),
      ),
    );
  }
}
