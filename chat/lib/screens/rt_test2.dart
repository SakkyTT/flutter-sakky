import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

User? user = FirebaseAuth.instance.currentUser;
String? uid = user!.uid;

// Data rakenne

// database root
//  - reservations
//    - generated ID (varauksen Id)
//      - datetime: "2024-02-20 12:47:57" <- ei toimi firebase Range vertailussa
//      - timestamp: 1713613291000 <- millisekunnit vuodesta 1970-00-00 00:00:00
//             kun aika ilmaistaan integer muodossa, sitä on helpompi vertailla
//           start: 1713613291000
//      - item_id: 1 (oikeasti firebase generoi)
//      - user_id: "cEWr4lr3Gertk4TkrR"
//    - generated ID
//      - datetime: "2024-05-20 12:47:57"
//      - item_id: 2
//      - user_id: "cEh5gh45g45grR"
//      - duration: 45
//  - users
//    - user Id, generated
//      - email: "test@test.test"
//      - name: "Test User"

// Otetaan yhteys tietokantaan .ref("jokin/polku")
// Polun voi myös määrittää myöhemmin eri paikkoihin, joten ref on tässä tyhjä
// joka on tietokannan root
final databaseReference = FirebaseDatabase.instance.ref();

class RtTest2Screen extends StatelessWidget {
  const RtTest2Screen({super.key});

  // Tällä funktiolla luodaan varaus tietokantaan
  void _createReservation() async {
    const datetime = "2024-01-15 12:02:12";
    int timestamp = DateTime.parse(datetime).millisecondsSinceEpoch;

    // Data, joka tallennetaan. JSON objekti.
    final reservation = {
      "user_id": uid,
      "item_id": 5, // Kovakoodataan 1 -> eteenpäin
      "timestamp": timestamp
    };

    databaseReference.child('reservations').push().set(reservation);

    // luetaan data kerran. Löytyy myös keino seurata dataa jos tarvetta
    DatabaseEvent event = await databaseReference.child('reservations').once();

    print('Tietokannan varaukset: ${event.snapshot.value}');
  }

  void _createUser() {
    final user = {
      "name": "testi 2",
      "phone": "56789",
    };

    databaseReference.child('user_data/$uid').set(user);
  }

  void _queryMyReservations() async {
    Query query = databaseReference
        .child('reservations') // Mikä dokumenttia selataan
        .orderByChild('user_id') // Mitä dataa tutkitaan
        .equalTo(uid); // Mikä arvo halutaan
    // Jotta query OIKEASTI toimii, tietokannan säännöissä
    // pitää olla indeksi määritettynä

    DatabaseEvent event = await query.once();
    print('Minun varaukset: ${event.snapshot.value}');
    // Oikeasti value:n data leivotaan johonkin malliin
    // Ja mallin perusteella generoidaan widgettejä
  }

  // Luodaan tässä käyttäjän tallennus tietokantaan

  void _logout() async {
    FirebaseAuth.instance.signOut();
  }

  // Haetaan varauksia tietyllä aikavälillä
  void _queryReservationsByDateRange() async {
    const startDatetime = '2024-01-12';
    const endDatetime = '2024-01-15';

    int timestampStart = DateTime.parse(startDatetime).millisecondsSinceEpoch;
    int timestampEnd = DateTime.parse(endDatetime).millisecondsSinceEpoch;

    Query query = databaseReference
        .child('reservations')
        .orderByChild('timestamp')
        .startAt(
            timestampStart) // ei ole pakko käyttää sekä aloitusta ja lopetusta
        .endAt(timestampEnd);

    DatabaseEvent event = await query.once();
    // Huom! jos halutaan päivittyvä käyttöliittymä pitää käyttää on()-metodia
    // joka palauttaa stream:in, joka toimii esim StreamBuilder widgetin kanssa
    // on()-metodi toimii hieman eri tavalla

    print('Alku - loppu: $timestampStart - $timestampEnd');
    print('Varaukset aika välillä: ${event.snapshot.value}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RealTime Test 2-app'),
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
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _createReservation,
              child: const Text('Create reservation!'),
            ),
            ElevatedButton(
              onPressed: _createUser,
              child: const Text('Create user!'),
            ),
            ElevatedButton(
              onPressed: _queryMyReservations,
              child: const Text('Check my reservations!'),
            ),
            ElevatedButton(
              onPressed: _queryReservationsByDateRange,
              child: const Text('Check reservations with range!'),
            ),
          ],
        ),
      ),
    );
  }
}
