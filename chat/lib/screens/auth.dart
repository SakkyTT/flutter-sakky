import 'dart:io'; // File-luokka

import 'package:chat/widgets/user_image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

// Tämän objektin välityksellä käytetään firebase:ia
final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Onko kirjautuminen vai registeröinti
  var _isLogin = true; // false == luodaan uusi tili

  final _formKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';

  File? _selectedImage;
  var _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid || !_isLogin && _selectedImage == null) {
      // Virhe ilmoitus....
      return; // Lopetetaan suoritus, jos data ei ole validi
    }

    // Suorittaa FormField:n save metodin
    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthenticating = true;
      });
      if (!_isLogin) {
        // Rekisteröinti

        // Yritetään suorittaa koodi (luodaan käyttäjä)
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        //print(userCredentials);

        // Jotta kuva voidaan tallentaa, ensin pitää luoda käyttäjä
        // Jos päästään tähän, käyttäjän luonti on onnistunut
        final storageRef = FirebaseStorage.instance // viittaus
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRef.putFile(_selectedImage!); // tallennetaan tiedosto
        final imageUrl = await storageRef.getDownloadURL();
        print(imageUrl);
      } else {
        // Kirjautuminen

        final userCredentials = await _firebase.signInWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        //print(userCredentials);
      } // Else päättyy
    } on FirebaseAuthException catch (error) {
      // Otetaan vastaan virheilmoitus
      if (error.code == 'email-already-in-use') {
        // Virhe ilmoitus, kun sähköposti on jo käytössä
      }
      // Tässä näytetään kaikki virheet samalla tavalla
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed!'),
          // Jos error.message == null, teksti = 'Authentication failed!'
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter your information'),
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!_isLogin)
                          UserImagePicker(onPickImage: (pickedImage) {
                            _selectedImage = pickedImage;
                          }),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              // Virhe
                              return 'Please enter a valid email address!';
                            }

                            return null; // ei virhettä
                          },
                          onSaved: (newValue) {
                            _enteredEmail = newValue!;
                          },
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              // Virhe
                              return 'Password must be at least 6 characters long!';
                            }

                            return null; // ei virhettä
                          },
                          onSaved: (newValue) {
                            _enteredPassword = newValue!;
                          },
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        if (_isAuthenticating)
                          const CircularProgressIndicator(),
                        if (!_isAuthenticating)
                          ElevatedButton(
                            onPressed: _submit,
                            child: Text(
                              _isLogin ? 'Login' : 'Signup',
                            ),
                          ),
                        if (!_isAuthenticating)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _isLogin = !_isLogin;
                              });
                            },
                            child: Text(
                              _isLogin
                                  ? 'Create an account'
                                  : 'I already have an account',
                            ),
                          ),
                        Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/flutter-test-2-b1504.appspot.com/o/user_images%2FdM1zS87ZH1f0gBLoEAWl6xCss1u1.jpg?alt=media&token=7593c71b-fab2-4f14-87a5-90bfc4c79908'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
