import 'package:flutter/material.dart';

import 'package:pitsa/Data/ingredients.dart';

class SelectIngredients extends StatelessWidget {
  const SelectIngredients({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('image here'),
          const Text('Text here'),
          ...ingredients.map((item) {
            // null chekkaus puuttuu
            //final quantity = selectedIngredientMap[ingredient] ?? 0;

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'data',
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
                  onPressed: () {},
                  icon: const Icon(Icons.remove_circle_outline_rounded,
                      color: Colors.red),
                ),
                IconButton(
                  padding: EdgeInsets.all(4),
                  constraints: BoxConstraints(maxHeight: 24, maxWidth: 24),
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_outline_rounded,
                      color: Colors.green),
                ),
              ],
            );
          })
        ],
      ),
    );
  }
}
