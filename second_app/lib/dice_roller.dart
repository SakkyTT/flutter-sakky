import 'package:flutter/material.dart';
import 'dart:math';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// _ <- alaviiva ennen luokan nimeä tekee luokasta "private"
// Tätä luokkaa voi ainoastaan käyttää tässä tiedostossa.
class _DiceRollerState extends State<DiceRoller> {
  // funktio
  // 000000000000000000000000000001
  // 100000000000000000000000000000

  // ei pidetä muuttujassa tallessa koko polkua, vaan muokataan ainoastaan
  // arvotun nopan arvoa.
  // polku on kovakoodattu image widgettiin, mutta siellä on lisätty
  // nopas arvo string arvoon.

  var currentDiceRoll = 2;

  void rollDice() {
    // koodi
    // määritetään anonyymi funktio
    setState(() {
      currentDiceRoll = random.nextInt(6) + 1;
      // Täällä muokatut luokkamuuttujat, aiheuttavat käyttöliittymän päivityksen
      // Tai ainoastaan tämän luokan päivityksen, joka tarkoittaa build-funktion
      // suorittamista uudelleen.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/d$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ), // antakaa tällä lapseksi kuva widget
        TextButton(
          // onPressed: () { <- anonyymi funktio
          //   // Tähän tulee koodi
          // },
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // yksi vaihtoehto erottaa widgettejä
            // padding: const EdgeInsets.only(
            //   top: 20,
            // ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        ),
      ],
    );
  }
}
