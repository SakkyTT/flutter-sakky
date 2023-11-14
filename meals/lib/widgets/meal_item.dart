import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        // Tämä stack ei liity screen stack asiaan
        child: Stack(
          // Widgetit, jotka ovat päällekkäin, ylin on alimmaisin
          children: [
            // Kuva latautuu/ilmestyy hitaasti
            FadeInImage(placeholder: placeholder, image: image)
          ],
        ),
      ),
    );
  }
}
