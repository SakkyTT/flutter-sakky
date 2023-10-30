import 'package:flutter/material.dart';
import 'package:tabs_testing/answer_button.dart';
import 'package:tabs_testing/model/quiz_question.dart';

class QuestionNormal extends StatelessWidget {
  const QuestionNormal(this.currentQuestion, this.onAnswer, {super.key});

  final QuizQuestion currentQuestion;

  final void Function(String) onAnswer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          currentQuestion.text,
        ),
        const SizedBox(height: 30),

        ...currentQuestion.shuffledAnswer.map(
          (item) {
            return AnswerButton(
                answerText: item,
                onTap: () {
                  onAnswer(item);
                  // muuta koodia
                });
          },
        )
        // map palauttaa listan, eli:
        // [widget, [widget, widget, widget], widget, widget jne]
        // lista ei kelpaa listaan widgettejä, joten se pitää purkaa
        // ... eli spread operaatio.
      ],
    );
  }
}
