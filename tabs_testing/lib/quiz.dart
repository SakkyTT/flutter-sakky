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
  List<String> selectedAnswers = []; // State

  int questionIndex = 0;

  // funktio
  void switchScreen(int tabIndex, BuildContext ctx) {
    //  setState suorittaa build function uudestaan ja UI voi päivittyä
    setState(
      () {
        //activeScreen = const QuestionScreen();  -versio 1-
        // Haetaan olemassa oleva tabController
        final TabController oldController = DefaultTabController.of(ctx);
        oldController.animateTo(tabIndex);
      },
    );
  }

  void chooseAnswer(String answer, int tabIndex, BuildContext ctx) {
    setState(() {
      questionIndex++;
    });
    selectedAnswers.add(answer);

    // kun lisätään käyttäjän vastauksiin uusi vastaus, tarkistetaan onko kaikki
    // vastaukset annettu
    if (selectedAnswers.length == questions.length) {
      setState(() {
        final TabController oldController = DefaultTabController.of(ctx);
        oldController.animateTo(tabIndex);

        //selectedAnswers.clear();
        //selectedAnswers = []; Tyhjentää vastaukset, korjataan myöhemmin
      });
    }
  }

  // Lisää funktio restartQuiz ja siinä tyhjennetään lista
  // ja navigoidaan questions-screen näkymään.

  void restartQuiz() {
    setState(() {
      // luodaan uusi lista objekti ja vanhan osoite katoaa ja roskien keruu
      // vapauttaa muistin.
      questionIndex = 0;
      selectedAnswers = [];
    });
  }

// Ensin tallennettiin koko widgetti muuttujaan (pointer objektiin)
// Nyt tallennetaan jokin oma nimi / arvo, jonka perusteella dynaamisesti
// tai ehdollisesti rakennentaan build:n sisällä haluttu widget

  @override
  Widget build(context) {
    // tässä välissä voidaan suorittaa koodia
    // Tässä ratkaistaan, mikä "sivu" näytetään

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
                StartScreen(switchScreen), //0 indeksi
                QuestionScreen(
                    onSelectAnswer: chooseAnswer,
                    currentIndex: questionIndex,
                    onDone: switchScreen), // 1 indeksi
                ResultsScreen(
                    // 2 indeksi
                    chosenAnswers: selectedAnswers,
                    onRestart: restartQuiz)
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
