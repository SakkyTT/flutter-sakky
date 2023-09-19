import 'package:flutter/material.dart';
import 'package:monivalinta/question_screen.dart';

import 'package:monivalinta/start_screen.dart';

// Widget
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// Widget state
class _QuizState extends State<Quiz> {
  // Määritellään muuttujan datatyypiksi Widget, koska molemmat luokat
  // Perivät sen
  //  -Versio 1-
  // Widget? activeScreen; // null, tarvitaan ? datatyypin jälkeen
  // int number = 45;

  // Käytetään Widgettien funktiota, joka suoritetaan kun objekti on luotu
  // @override
  // void initState() {
  //   super.initState(); // Tämä tapahtuu ekana
  //   // Koska initState tapahtuu ennen build funktiota, ei tarvita setState
  //   activeScreen = StartScreen(switchScreen);
  // }

  // - Versio 2 -   ctrl +k + c = kommentit

  var activeScreen = 'start-screen'; // Ei tarvitse null arvoa

  // funktio
  void switchScreen() {
    //  setState suorittaa build function uudestaan ja UI voi päivittyä
    setState(
      () {
        //activeScreen = const QuestionScreen();  -versio 1-
        activeScreen = 'question-screen';
      },
    );
  }

// Ensin tallennettiin koko widgetti muuttujaan (pointer objektiin)
// Nyt tallennetaan jokin oma nimi / arvo, jonka perusteella dynaamisesti
// tai ehdollisesti rakennentaan build:n sisällä haluttu widget

  @override
  Widget build(context) {
    // tässä välissä voidaan suorittaa koodia
    // Tässä ratkaistaan, mikä "sivu" näytetään

    // build funktion sisällä, ei ole ongelmaa käyttää switchScreen parametriä
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = const QuestionScreen();
    }

    return MaterialApp(
      // 1. aloitus näkymä
      // 2. lista kysymys näkymiä
      // 3. tulos näkymä
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 98, 184, 36),
                  Color.fromARGB(255, 142, 249, 110)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: screenWidget
            // ternary expression, toimii kuin if else
            // activeScreen == 'start-screen' // Vertailu, antaa true tai false
            //     ? StartScreen(switchScreen) // ? on true kohta
            //     : const QuestionScreen(), // : on false kohta
            ),
      ),
    );
  }
}
