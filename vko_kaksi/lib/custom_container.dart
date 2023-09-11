import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
// constructor funktio, joka suoritetaan, kun luokasta tehdään objekti.
  const CustomContainer({super.key});

  // funktio
  @override
  Widget build(context) {
    return Container(
      color: Colors.teal,
      transform: Matrix4.rotationX(5),
      child: const Center(child: Text("Terve")),
    );
  }
}
