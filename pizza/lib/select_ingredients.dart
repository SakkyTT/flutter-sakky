import 'package:flutter/material.dart';

import 'package:pizza/data/ingredients.dart';
import 'package:pizza/models/ingredient.dart';

class SelectIngredients extends StatelessWidget {
  const SelectIngredients(this.selectedIngredients,
      {super.key, required this.onAddIngredient});

  final void Function(Ingredient) onAddIngredient;
  final List<Map<Ingredient, int>> selectedIngredients;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('image here'),
        const Text('text here'),
        // Tähän generoidaan buttonit

        // widget
        // widget
        //
        // [widget, widget, widget] ... =>  widget,
        //                                  widget,
        //                                  widget

        // ingredients on lista Ingredient luokan objekteja
        // Siitä halutaan käydä data läpi ja muokata ne widget muotoon.
        // ... spread purkaa listan
        ...ingredients.map((item) {
          // Haetaan yläpuolella käytävän Ingredient objektin (item) map<Ingredient, int>
          // Ja siitä map objektista saadaan lukumäärä, montako kertaa se on valittu.
          // map löytyy selectedIngredients listasta.
          final mapOfOneSelectedIngredient = selectedIngredients.firstWhere(
            (oneMap) => oneMap.containsKey(item),
            orElse: () => {},
          );

          // otetaan avain-arvo parista arvo talteen <int>
          final numberOfPortions = mapOfOneSelectedIngredient[item];

          return Row(
            children: [
              TextButton(
                onPressed: () {
                  onAddIngredient(item);
                },
                child: Text('${item.name} = $numberOfPortions'),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.remove_circle,
                  color: Colors.red,
                ),
              ),
              IconButton(
                onPressed: () {
                  onAddIngredient(item);
                },
                icon: const Icon(
                  Icons.add_circle,
                  color: Colors.green,
                ),
              ),
            ],
          );
        })
      ],
    );
  }
}
