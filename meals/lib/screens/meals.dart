import 'package:flutter/material.dart';
import 'package:meals/main.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:meals/screens/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.title, required this.meals});

  final String
      title; // Tulee category_grid_item widgetistä tai missä muualla tätä käytetään
  final List<Meal> meals; // Tulee category_grid_item widgetistä

  void selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Oletus content sivulla
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealItem(
        meal: meals[index],
        onSelectMeal: () {
          selectMeal(context, meals[index]);
        },
      ),
    );

    // Tarkistetaan onko lista tyhjä
    if (meals.isEmpty) {
      // Luodaan jokin toinen context scaffold widgetin body osioon
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '... nothing here!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Try selecting a different category!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      // generoi body parametriin lista aterioite, huomioi, että lista voi olla todella pitkä
      // jos ei ole yhtään ateriaa, näytetään jokin toinen teksti (categoria tyhjä)
      // näytä listassa vain Text widget, jossa aterian otsikko.
      body: content,
    );
  }
}
