import 'package:flutter/material.dart';
import 'package:pizza/models/ingredient.dart';

import 'package:pizza/select_ingredients.dart';

class PizzaBuilder extends StatefulWidget {
  const PizzaBuilder({super.key});

  @override
  State<PizzaBuilder> createState() => _PizzaBuilderState();
}

class _PizzaBuilderState extends State<PizzaBuilder> {
  final List<Map<Ingredient, int>> selectedIngredients = [];

  void incrementIngredient(Ingredient ingredient) {
    setState(() {
      final Map<Ingredient, int> ingredientMap = selectedIngredients
          .firstWhere((element) => element.containsKey(ingredient), orElse: () {
        final newMap = {ingredient: 1};
        selectedIngredients.add(newMap);
        return newMap;
      });
      ingredientMap[ingredient] = (ingredientMap[ingredient] ?? 0) + 1;
      // (ingredientMap[ingredient] ?? 0) jos ingredientMap[ingredient] == null
      // laitetaan tilalle arvo 0, ei sovellus kaadu null arvon vuoksi.
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: SelectIngredients(selectedIngredients,
              onAddIngredient: incrementIngredient),
        ),
      ),
    );
  }
}
