import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/providers/favorites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({
    super.key,
    required this.meal, // Nämä ovat parametrejä (mitä halutaan ottaa vastaan)
    // required this.onToggleFavorite,
  });

  final Meal meal;
  // final void Function(Meal meal) onToggleFavorite;

  @override
  // ConsumerWidget vaatii build:iin erikseen ref parametrin
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    // Tarkistetaan onko ateria suosikeissa, eli onko aterian suosikit listan sisällä
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(title: Text(meal.title), actions: [
        IconButton(
          // onPressed on IconButton luokan parametri ja : oikealla puolen
          // on meidän syöttä argumentti
          onPressed: () {
            // .read(), koska olemme funktion sisällä. watch aiheuttaa ongelmia
            final wasAdded = ref
                .read(favoriteMealsProvider.notifier)
                .toggleMealFavoritesStatus(meal);
            ScaffoldMessenger.of(context)
                .clearSnackBars(); // Poistetaan vanha viesti
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(wasAdded
                    ? 'Meal was added as a favorite.'
                    : 'Meal removed.'),
              ),
            );
            // onToggleFavorite(meal); // tämä on argumentti (mitä yritetään antaa)
          },
          icon: Icon(isFavorite ? Icons.star : Icons.star_border),
        )
      ]),
      // ListView() / ListView.Builder() Toinen vaihtoehto
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 14,
            ),
            Text(
              'Ingredients',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            // ...meal.ingredients.map((e) => Text(e)).toList(),
            for (final ingredient in meal.ingredients)
              Text(
                ingredient,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Steps',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 14,
            ),
            // ...meal.ingredients.map((e) => Text(e)).toList(),
            for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
