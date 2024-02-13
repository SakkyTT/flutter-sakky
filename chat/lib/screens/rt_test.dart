import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;
String? uid = user!.uid;

final databaseReference = FirebaseDatabase.instance.ref('users/$uid');

const timestamp = '17050495034595'; // Tähän generoidaan tämän hetken timestamp
final timestamp2 = DateTime.now().millisecondsSinceEpoch;
final databaseReference2 =
    FirebaseDatabase.instance.ref('reservations/$timestamp');

class RtTestScreen extends StatelessWidget {
  const RtTestScreen({super.key});

  void _userDatabase() async {
    print(timestamp2);
    print(uid);
    final data = {
      //"users": {
      //   "$uid": {
      "varaukset": [
        {
          "name": "User 1",
          "email": "user1@example.com",
        },
        {
          "name": "User 2",
          "email": "user2@example.com",
        },
        {
          "name": "User 3",
          "email": "user3@example.com",
        },
      ]
      // }
      //   }
    };

    DatabaseEvent event = await databaseReference.once();

    print(event.snapshot.value);

    databaseReference.set(data);
  }

  void _logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RealTime Test-app'),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _userDatabase,
          child: const Text('Use Database!'),
        ),
      ),
    );
  }
}
