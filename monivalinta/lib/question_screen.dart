// Luo stateful widget, joka palauttaa Text widgetin tekstillä "Question Screen"

import 'package:flutter/material.dart';

import 'package:monivalinta/answer_button.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});
  // createState
  @override
  State<QuestionScreen> createState() {
    return _QuestionScreenState();
  }
}

// Luokan nimessä on alaviiva, joten se on yksityinen
// Yksityistä luokkaa voi käyttää vain tämän tiedoston sisäiset koodit
class _QuestionScreenState extends State<QuestionScreen> {
  // build
  @override
  Widget build(context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Question',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 30),
          AnswerButton(answerText: 'Vastaus')
        ],
      ),
    );
    // 1. otetaan koko sivu käyttöön. lisää siihen tarkoitukseen oikea widget
    // 2. sisältö on keskellä ruutua x ja y suunnassa. siihen widget ja asetukset
    // 3. teksti, johon tulee sitten kysymys
    // 4. OutlinedButton x 4, joissa valitaan oikea vastaus
  }
}
