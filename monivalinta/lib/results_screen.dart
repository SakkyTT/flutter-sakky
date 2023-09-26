import 'package:flutter/material.dart';

import 'package:monivalinta/data/questions.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers});

  final List<String> chosenAnswers;

  // Map on datarakenne, jossa voidaan määritellä key: value pareja.
  // Esim ikä(key): 33(value)
  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = []; // Luodaan lista

    // Generoidaan data... 0 1 2 3 4 5 <- nuo i arvot suoritetaan
    for (var i = 0; i < chosenAnswers.length; i++) {
      // For Loop Body
      summary.add({
        // key: value
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0], // Magic Number
        'user_answer': chosenAnswers[i]
      });
    }

    return summary; // Palautetaan lista
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You answered X out of Y questions correctly!'),
            const SizedBox(
              height: 30,
            ),
            const Text('List of answers and questions here...'),
            const SizedBox(
              height: 30,
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Restart Quiz!'),
            ),
          ],
        ),
      ),
    );
  }
}
