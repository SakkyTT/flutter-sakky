import 'package:flutter/material.dart';

// immutable = asiaa ei voi muokata
class StyledText extends StatelessWidget {
  // Constructor
  const StyledText(this.text, {super.key});

  // Luokkamuuttuja / property
  final String text;

  // Metodi (funktio)
  @override
  Widget build(BuildContext context) {
    return Text(
      // Siirretään Text omaan tiedostoon ja luokkaan "styled_text"
      // isompi fontti ja valkoinen väri
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
