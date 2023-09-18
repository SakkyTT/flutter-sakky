import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Opacity(
          //   opacity: 0.55,
          //   child: Image.asset(
          //     'assets/images/question.png',
          //     width: 150,
          //   ),
          // ), ctrl + k + c -> ctrl + k + u poistaa kommentit
          Image.asset(
            'assets/images/question.png',
            width: 150,
            color: const Color.fromARGB(144, 255, 255, 255),
          ),
          const SizedBox(
            height: 60,
          ),
          const Text(
            'Start Screen',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Start Quiz'),
          ),
        ],
      ),
    );
  }
}
