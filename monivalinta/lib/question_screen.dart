// Luo stateful widget, joka palauttaa Text widgetin tekstillä "Question Screen"

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:monivalinta/answer_button.dart';
import 'package:monivalinta/data/questions.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer) onSelectAnswer;

  // createState
  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

// Luokan nimessä on alaviiva, joten se on yksityinen
// Yksityistä luokkaa voi käyttää vain tämän tiedoston sisäiset koodit
class _QuestionScreenState extends State<QuestionScreen> {
  var currentQuestionIndex = 0;

  void answerQuestion(String selectedAnswer) {
    widget.onSelectAnswer(selectedAnswer);
    //currentQuestionIndex = currentQuestionIndex + 1;
    //currentQuestionIndex += 1;
    setState(() {
      currentQuestionIndex++;
    });
  }

  // build
  @override
  Widget build(context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Center(
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.text,
              style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // map funktio käy läpi datan listassa, suorittaa funktion jokaista
            // listan itemiä kohden ja tallentaa uuden datan, uuteen listaan.
            // Uusi lista ei näy koodissa, se vain ilmestyy tähän kohtaan, jossa
            // suoritetaan map() funktio.
            ...currentQuestion.getShuffledAnswer().map(
              (item) {
                return AnswerButton(
                    answerText: item,
                    onTap: () {
                      answerQuestion(item);
                      // muuta koodia
                    });
              },
            )
            // map palauttaa listan, eli:
            // [widget, [widget, widget, widget], widget, widget jne]
            // lista ei kelpaa listaan widgettejä, joten se pitää purkaa
            // ... eli spread operaatio.
          ],
        ),
      ),
    );
    // 1. otetaan koko sivu käyttöön. lisää siihen tarkoitukseen oikea widget
    // 2. sisältö on keskellä ruutua x ja y suunnassa. siihen widget ja asetukset
    // 3. teksti, johon tulee sitten kysymys
    // 4. OutlinedButton x 4, joissa valitaan oikea vastaus
  }
}
