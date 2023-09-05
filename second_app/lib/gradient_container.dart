import 'package:flutter/material.dart';
import 'package:second_app/styled_text.dart';

class GradientContainer extends StatelessWidget {
  // tätä luokkaa voidaan käyttää monilla eri sivuilla. (Modulaarisuus)
  // Ja koodin pilkkominen pienempiin osiin voi helpottaa sen lukemista.

  // Constructor
  const GradientContainer({super.key});
  // { const constructorilla ei voi olla body osaa.
  // voi olla myös erillinen koodi body
  // initialization code
  // }

  // funktio / metodi
  @override // muistiinpano, kun peritään jokin vaatimus "extends" toiminnalla
  Widget build(context) {
    return Container(
      // Abstract luokka ei voi luoda objectia, siitä vaan peritään asioita
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Color.fromARGB(255, 111, 244, 180), Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight // ctrl + alt
            ),
      ), // ctrl + välilyönti
      child: const Center(child: StyledText() // ctrl + spacebar
          ),
    );
  }
}
