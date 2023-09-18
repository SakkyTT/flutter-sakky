import 'package:flutter/material.dart';

import 'package:monivalinta/start_screen.dart';

// Widget
class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

// Widget state
class _QuizState extends State<Quiz> {
  @override
  Widget build(context) {
    return MaterialApp(
      // 1. aloitus näkymä
      // 2. lista kysymys näkymiä
      // 3. tulos näkymä
      home: Scaffold(
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
          child: const StartScreen(),
        ),
      ),
    );
  }
}
