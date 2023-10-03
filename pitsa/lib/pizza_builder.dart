import 'package:flutter/material.dart';

import 'package:pitsa/Models/ingredient.dart';
import 'package:pitsa/select_ingredients.dart';

class PizzaBuilder extends StatefulWidget {
  const PizzaBuilder({super.key});

  @override
  State<PizzaBuilder> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<PizzaBuilder> {
  List<Map<Ingredient, int>> selectedIngredients = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: const SelectIngredients(),
        ),
      ),
    );
  }
}
