import 'package:flutter/material.dart';

class QuestionDone extends StatelessWidget {
  const QuestionDone({super.key, required this.onDone});

  final void Function(int, BuildContext) onDone;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('You have answered all the questions, go see your results!'),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () {
            onDone(2, context);
          },
          child: const Text('Results!'),
        ),

        // map palauttaa listan, eli:
        // [widget, [widget, widget, widget], widget, widget jne]
        // lista ei kelpaa listaan widgettejä, joten se pitää purkaa
        // ... eli spread operaatio.
      ],
    );
  }
}
