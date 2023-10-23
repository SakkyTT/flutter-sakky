// Tähän stateless widget, constructor ja build palauttaa tyhjän rivin
// Tässä tiedostossa on yksi rivi tuloksia.
// Käytetään questions_identifuer widgettiä ja sarakeessa kysymys, vastaus ja
// oikea vastaus

import 'package:flutter/material.dart';
import 'package:tabs_testing/questions_summary/questions_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = // Saadaan true tai false, onko vastaus oikein
        itemData['user_answer'] == itemData['correct_answer'];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionIdentifier(
          isCorrectAnswer: isCorrectAnswer,
          questionIndex: itemData['question_index'] as int,
        ),
        const SizedBox(
          width: 20,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                itemData['question'] as String,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                itemData['user_answer'] as String,
                style: TextStyle(
                  color: isCorrectAnswer ? Colors.blue : Colors.orange,
                ),
              ),
              Text(
                itemData['correct_answer'] as String,
                style: TextStyle(
                  color: isCorrectAnswer ? Colors.blue : Colors.green,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
