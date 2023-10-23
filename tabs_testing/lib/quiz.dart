import 'package:flutter/material.dart';
import 'package:tabs_testing/data/questions.dart';
import 'package:tabs_testing/question_screen.dart';
import 'package:tabs_testing/results_screen.dart';

import 'package:tabs_testing/start_screen.dart';

// Widget
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// Widget state, ja tässä _ ennen luokan nimeä tekee siitä yksityisen
// Kun jokin asia on yksityinen, sitä voi käyttää vain sen tiedoston sisällä
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

  List<String> selectedAnswers = []; // State
  var activeScreen = 'start-screen'; // Ei tarvitse null arvoa

  // _ voidaan laittaa myös properteihin ja metodeihin
  // Eli julkisella luokassa voi olla yksityisiä osia
  //   var _activeScreen = 'start-screen';
  // void _switchScreen() {

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

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    // kun lisätään käyttäjän vastauksiin uusi vastaus, tarkistetaan onko kaikki
    // vastaukset annettu
    if (selectedAnswers.length == questions.length) {
      setState(() {
        //selectedAnswers.clear();
        //selectedAnswers = []; Tyhjentää vastaukset, korjataan myöhemmin
        activeScreen = 'results-screen';
      });
    }
  }

  // Lisää funktio restartQuiz ja siinä tyhjennetään lista
  // ja navigoidaan questions-screen näkymään.

  void restartQuiz() {
    setState(() {
      // luodaan uusi lista objekti ja vanhan osoite katoaa ja roskien keruu
      // vapauttaa muistin.
      selectedAnswers = [];
      activeScreen = 'question-screen';
    });
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
      screenWidget = QuestionScreen(onSelectAnswer: chooseAnswer);
    } else if (activeScreen == 'results-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
      );
    }

    return MaterialApp(
      // 1. aloitus näkymä
      // 2. lista kysymys näkymiä
      // 3. tulos näkymä
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tabs testi'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ]),
          ),
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
              child: TabBarView(children: [
                StartScreen(switchScreen),
                QuestionScreen(onSelectAnswer: chooseAnswer),
                ResultsScreen(
                    chosenAnswers: selectedAnswers, onRestart: restartQuiz)
              ])
              // ternary expression, toimii kuin if else
              // activeScreen == 'start-screen' // Vertailu, antaa true tai false
              //     ? StartScreen(switchScreen) // ? on true kohta
              //     : const QuestionScreen(), // : on false kohta
              ),
        ),
      ),
    );
  }
}
