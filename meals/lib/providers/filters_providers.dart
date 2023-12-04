import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

// Dynaaminen (muuttuva) state
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super(
            // Oletus data state:iin
            {
              // Kaikki oletuksena false
              Filter.glutenFree: false,
              Filter.lactoseFree: false,
              Filter.vegetarian: false,
              Filter.vegan: false,
            });

  // Päivitetään dataa metodilla
  // immutable tavalla
  //              Filter.vegan, true
  void setFilter(Filter filter, bool isActive) {
    // state on nyt rakenteeltaan: Map<Filter, bool>
    // state[filter] = isActive; // Ei sallita! => mutable muokkaus

    // Täytyy luoda uusi map muistiin ja korvata kokonaan vanha map
    state = {
      ...state, // Puretaan vanha map
      filter: isActive, // ylikirjoitetaan uusi data
      // Filter.vegan: true,
      // Filter.vegan: false, // Vain tämä jää talteen
    };
  } // setFilter

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }
}

// FiltersNotifier() => luokan nimen perässä () => luodaan objekti luokasta
final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

// Provider, joka palauttaa dataa muiden provider:ien datan pohjalta
final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && meal.isGlutenFree == false) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && meal.isLactoseFree == false) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && meal.isVegetarian == false) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && meal.isVegan == false) {
      return false;
    }
    return true;
  }).toList();
});
