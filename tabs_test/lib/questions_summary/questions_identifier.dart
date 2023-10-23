import 'package:flutter/material.dart';

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier(
      {super.key, required this.isCorrectAnswer, required this.questionIndex});

  final int questionIndex;
  final bool isCorrectAnswer; // Määrittää taustavärin

  @override
  Widget build(BuildContext context) {
    // container, johon pyöreä taustaväri.
    // punainen jos väärin, sininen jos oikein, käytetään ternary operaatiota
    // container lapseksi text widget, jossa kysymyksen numero.

    final questionNumber = questionIndex + 1;

    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          // tähän väri
          color: isCorrectAnswer == true ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.circular(100)),
      child: Text(
        questionNumber.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
