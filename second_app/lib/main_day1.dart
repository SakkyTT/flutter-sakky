import 'package:flutter/material.dart';

// Koodi rakentuu kahdesta erillaisista "sanoista"
// 1. keywords, ohjelmointikieli määrittelee
// 2. identifiers, ohjelmoijat määrittelevät

void main() {
  // Määritellään funktio, tämä "main" on dart kielen aloitus piste

  // funktion body
  runApp(
    const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'), // pilkku, sulkujen jälkeen
        ),
      ),
    ),
  ); // Suoritetaan flutter frameworkin funktio
} // const, data on immutable

void add({num1, num2}) {
  // määritellään, named parameters
  num1 + num2; // 3 ja 5
}

void test() {
  add(num1: 3, num2: 5); // suoritetaan, käytetään named parameters
}


// Repo on "projekti" Git-ympäristössä.
// Eli ensin pitää luoda Repo, jonne tallennetaan tiedostoja.
// Repon voi luoda ensin joko GitHub-palveluun tai omalle koneelle.








