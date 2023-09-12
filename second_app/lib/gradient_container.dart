import 'package:flutter/material.dart';
import 'package:second_app/styled_text.dart';
import 'package:second_app/dice_roller.dart';

// Muuttuja    operaatio   muuttujan arvo

Alignment startAlignment = Alignment.topLeft;

// Muuttujalla täytyy olla arvo kun se luodaan, jos ei erikseen määritellä
// Että se voi olla null. Sen tekee ? muuttujan nimen perässä.
// Alignment? startAlignment;

// Vältetään dynaamisia muuttujia
// var thisIsDynamic;  <- ei määritellä data tyyppiä

// final (runtime) endAlignment = Alignment.bottomRight;
// final currentDay = getDay(); <- arvo voidaan "suorittaa" funktiosta
// final avainsana, muuttujan arvo ei ikinä muutu sovelluksen ajon aikana.
// final parantaa sovelluksen suorituskykyä ja jos muuttujan ei ole tarkoitus
// Sovelluksen logiikan perusteella muuttua, se kannattaa määritellä final

const endAlignment = Alignment.bottomRight;

// const (compile time) toimii samalla tavalla kuin final, mutta sen arvo määritellään
// Koodin käännön yhteydessä. Ei tarvitse suorittaa koodia, kun sovellus
// käynnistyy. (Joka määrittää muuttujan arvon)

class GradientContainer extends StatelessWidget {
  // tätä luokkaa voidaan käyttää monilla eri sivuilla. (Modulaarisuus)
  // Ja koodin pilkkominen pienempiin osiin voi helpottaa sen lukemista.

  void test() {
    startAlignment = Alignment.topLeft;
    //startAlignment = "test";
  }

  // Constructor
  // const GradientContainer(this.color1, this.color2, {super.key});
  // // { const constructorilla ei voi olla body osaa.
  // // voi olla myös erillinen koodi body
  // // initialization code
  // // }
  // final Color color1;
  // final Color color2;

  const GradientContainer({super.key, required this.colors});

  // Nimetty constructor
  GradientContainer.deepPurple({
    super.key,
  }) : colors = [Colors.deepPurple, const Color.fromARGB(255, 118, 77, 187)];

  // Properties (fields)
  final List<Color> colors;

  // funktio / metodi
  @override // muistiinpano, kun peritään jokin vaatimus "extends" toiminnalla
  Widget build(context) {
    return Container(
      // Abstract luokka ei voi luoda objectia, siitä vaan peritään asioita
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: colors,
            begin: startAlignment,
            end: endAlignment // ctrl + alt
            ),
      ), // ctrl + välilyönti
      child: Center(
        child: DiceRoller(),
        // ctrl + spacebar
      ),
    );
  }
}

// Harjoitus: muokkaa GradientContainer ottamaan vastaan kaksi väriä(color).

// Column ja Row widgetit
// Column, on widgetti johon voi laittaa useamman widgetin päällekkäin
// Row, on widgetti, johon voi laittaa useamman widgetin vierekkäin

// 1. Anonyymi funktio / anonymous function: () {}
// 2. Nimetty funktio