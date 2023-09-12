import 'package:flutter/material.dart';

// immutable = asiaa ei voi muokata
class StyledText extends StatelessWidget {
  // Constructor
  const StyledText(this.text, {super.key}) : num = 5;

  const StyledText.hello(this.num, {super.key}) : text = 'hello';

  // Luokkamuuttuja / property
  final String text;
  final int num;

  // Metodi (funktio)
  @override
  Widget build(BuildContext context) {
    return Text(
      // Siirretään Text omaan tiedostoon ja luokkaan "styled_text"
      // isompi fontti ja valkoinen väri
      text + num.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 28,
      ),
    );
  }
}
