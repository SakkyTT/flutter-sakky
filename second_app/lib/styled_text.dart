import 'package:flutter/material.dart';

class StyledText extends StatelessWidget {
  // Constructor
  const StyledText({super.key});

  // Metodi (funktio)
  @override
  Widget build(BuildContext context) {
    return const Text(
      // Siirretään Text omaan tiedostoon ja luokkaan "styled_text"
      // isompi fontti ja valkoinen väri
      'oma teksti',
      style: TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
