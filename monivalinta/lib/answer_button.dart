import 'package:flutter/material.dart';

class AnswerButton extends StatelessWidget {
  const AnswerButton({super.key, required this.answerText});

  final String answerText;

  @override
  Widget build(context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(),
      child: Text(answerText),
    );
  }
}
