// rt = realtime database
//
// Tämä tiedosto ottaa yhteyden käyttäjän varauksiin (firebase realtime database)
// ja näyttää ne käyttäjälle StreamBuilder avulla, jolloin käyttöliittymä
// päivittyy tietokannan tiedon perusteella automaattisesti

import 'package:flutter/material.dart';
// firebase importit
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

// Haetaan kirjautuneen käyttäjän uid, tämän id:n perusteella haetaan data
User? user = FirebaseAuth.instance.currentUser;
String? uid = user!.uid; // Tälle sivulle pääsee vain kirjautunut käyttäjä

// realtime database viittaus (juureen)
final databaseReference = FirebaseDatabase.instance.ref();

class RtStreamScreen extends StatelessWidget {
  const RtStreamScreen({super.key});

  void _createReservation() async {
    const datetime = "2024-05-15 12:02:12";
    int timestamp = DateTime.parse(datetime).millisecondsSinceEpoch;

    // Data, joka tallennetaan. JSON objekti.
    final reservation = {
      "user_id": uid,
      "item_id": 15, // Kovakoodataan 1 -> eteenpäin
      "timestamp": timestamp
    };

    databaseReference.child('reservations').push().set(reservation);
  }

  @override
  Widget build(BuildContext context) {
    print(uid);

    // Generoidaan käyttöliittymä StreamBuilder rakenteella
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreamBuilder'),
      ),
      // stream = yhteys tietokantaan
      // builder = rakennetaan UI
      body: StreamBuilder(
        stream: databaseReference
            .child('reservations')
            .orderByChild(
                'user_id') // tässä pitää olla käyttäjän id, jos sillä haetaan dataa
            .equalTo(uid) // haetaan vain kirjautuneen käyttäjän varaukset
            .onValue,
        builder: (context, snapshot) {
          // Virheiden tarkistus jne

          // ladataan tietoa, näytetään spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // saadaan virhe
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
            // Oikeasti ei välttämättä näytetän täysin oikeaa virhettä
            // käyttäjälle
          }

          // Ei ole dataa (normaalisti true menee läpi, mutta ! tarkoittaa
          // että false menee läpi)
          if (!snapshot.hasData || snapshot.data!.snapshot.value == null) {
            return const Center(child: Text('No reservations found.'));
          }

          // Tänne päästään kun saadaan dataa
          // Otetaan data talteen muuttujaan, voi olla myös List<Model>
          // Eli Json data => List<JokinLuokka>
          // print(snapshot.data!.snapshot.value);
          Map<dynamic, dynamic>? data =
              snapshot.data!.snapshot.value as Map<dynamic, dynamic>;
          // data[0].user_id <- ei toimi ilman malli luokkaa

          var reservations = <Map<dynamic, dynamic>>[];

          // Leivotaan JSON objektia sopivaan muotoon
          data.forEach((key, value) {
            reservations.add(value);
          });

          // Järjestetään data, voisi olla järjestetty timestamp mukaan myös
          reservations.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));

          // generoidaan widget puu (UI)
          return Column(
            children: [
              Expanded(
                // ListView käy läpi data muuttujan sisällön (jossa on varaukset)
                child: ListView.builder(
                  itemCount: reservations.length,
                  itemBuilder: (context, index) {
                    // yksi varaus
                    final reservation = reservations[index];
                    return ListTile(
                      title: Text('Timestamp: ${reservation['timestamp']}'),
                      subtitle: Text('Item ID: ${reservation['item_id']}'),
                      trailing: Text('User ID: ${reservation['user_id']}'),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: _createReservation,
                child: const Text('Create reservation!'),
              ),
            ],
          );
        },
      ),
    );
  }
}
