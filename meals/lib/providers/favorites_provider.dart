import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/models/meal.dart';
// Geneerinen, voi sisältää mitä tahansa dataa
// List<jotakinDataa>

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  // 1. data
  FavoriteMealsNotifier() : super([]); // Oletuksena tyhjä lista

  // 2. metodit, jotka muokkaa dataa
  // Riverpod, data täytyy muokata immutable tavalla
  // mutable: muokataan objektin dataa heap:ssä
  // immutable: luodaan kokonaan uusi objekti heap:iin ja korvataan vanha objekti
  // eli korvataan vanhan objektin viittaus uudella objektilla

  bool toggleMealFavoritesStatus(Meal meal) {
    // Tarkistetaan onko ateria jo suosikit listalla
    // contains metodi ei muokkaa listaa
    // state on nimi joka tulee riverpod koodista
    final mealIsFavorite = state.contains(meal);

    // meal löytyy, eli poistetaan suosikki
    if (mealIsFavorite == true) {
      // Kopioidaan ateriat vanhasta listasta "state", uuteen listaan []
      // mutta poistetaan "meal" uudesta listasta
      // where on immutable, eli se tekee uuden kopion
      // kopioidaan kaikki ateriat, joiden id ei ole se id, joka halutaan poistaa
      state = state.where((m) => m.id != meal.id).toList();
      return false; // Poistettu
    } else {
      // spread ... operaatio luo kopion elementeistä ja laitetaan ne
      // uuden listan [] sisälle
      state = [...state, meal]; // lopuksi uusi elementti , jälkeen
      return true; // lisätty
    }

    // Tässä on immutable datan muokkaus, [] luo uuden listan
    // ja laitetaan kokonaan uusi lista objekti vanhan tilalle
    // state = [];

    // Tämä on mutable keino, eli muokataan olemassa olevaan objektia (dataa)
    // state.add(meal);
  }
}

// Dynaaminen data, StateNotifierProvider
final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
