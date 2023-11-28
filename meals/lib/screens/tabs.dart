import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';

// k on käytäntö flutterissa const arvoja varten
const kInitialFilters = {
  // määritellään kaikki false, jotta ei tule null ongelmia
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

// Riverpod widgetit, niiden käyttö mahdollistaa ominaisuudet
// StatefulWidget => ConsumerStatefulWidget
// (StatelessWidget => ConsumerWidget)
class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  // State => ConsumerState
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

// State => ConsumerState
class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0; // Tämän perusteellä näytetään oikea sivu
  //final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  // Funktio / metodi
  // Kaikki metodit ovat funktioita,
  // mutta vain luokan funktiot ovat metodeja
  // Jos ateria ei ole suosikki, lisätän se suosikkeihin
  // Jos ateria on jo suosikki, otetaan se pois
  // void _toggleMealFavoriteStatus(Meal meal) {
  //   // Tutkitaan onko ateria jo listassa
  //   final isExisting = _favoriteMeals.contains(meal);

  //   // Suoritetaan poisto / lisäys
  //   // if (_favoriteMeals.contains(meal)) {
  //   if (isExisting) {
  //     setState(() {
  //       _favoriteMeals.remove(meal);
  //     }); // Kuinka saadaan aterian nimi lisättyä viestiin?
  //     _showInfoMessage("${meal.title} removed from favorites!");
  //   } else {
  //     setState(() {
  //       _favoriteMeals.add(meal);
  //     });
  //     _showInfoMessage("Marked as a favorite!");
  //   }
  // }

  // void _showInfoMessage(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars(); // Poistetaan vanha viesti
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String indentifier) async {
    Navigator.of(context).pop(); // Suljetaan ensin drawer
    if (indentifier == 'filters') {
      // Tässä tabs jää odottamaan, mitä filters palauttaa
      // Yleinen esimerkki on datan haku tietokannasta
      // List<String, anythingAtAll> <- geneerinen
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilters: _selectedFilters),
        ),
      );

      // Jos on arvo result:ssa, tallennetaan se
      // Tai sitten oletuksena kInitialFilters, jos result on null
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
    // if (indentifier == 'filters') {
    //   Korvataan nykyinen screen uudella screenillä
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (ctx) => const FiltersScreen(),
    //     ),
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    // Lisätään muuttuja, johon tallennetaan suodatettu aterialista
    // Käyttäjän valinnan perusteella
    // where => käydään läpi kaikki ateriat, joiden tagit vastaa
    // käyttäjän valintaa
    // where suorittaa funktion, jossa on logiikka, säilytetäänkö (true) elementti
    // vai ei (false)

    // ref on osana RiverPod pakettia
    // ref.read() <- lukee datan kerran
    // suositellaan watch(), se suorittaa build uudestaan jos data muuttuu
    // eli päivittää käyttöliittymään uuden datan
    final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal) {
      // Jos käyttäjä on valinnut gluten free && (ja)
      // ateria ei ole (! => false => true => if toteutuu) gluten free
      // Poistetaan ateria
      // Tutkitaan käyttäjän valinta ja mikä on aterian data
      // if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      if (_selectedFilters[Filter.glutenFree]! && meal.isGlutenFree == false) {
        // Halutaan false kun käyttäjä on valinnut gluten free,
        // mutta ateria ei ole gluten free
        return false;
      }
      if (_selectedFilters[Filter.lactoseFree]! &&
          meal.isLactoseFree == false) {
        return false;
      }
      if (_selectedFilters[Filter.vegetarian]! && meal.isVegetarian == false) {
        return false;
      }
      if (_selectedFilters[Filter.vegan]! && meal.isVegan == false) {
        return false; // Poistetaan ateria
      }
      // Nyt ollaan käyty läpi kaikki suodattimet
      // Lopuksi palautetaan ateria, jos tänne asti on päästy
      return true; // Ateria on ok
    }).toList(); // Iterable => List

    Widget activePage = CategoriesScreen(
      // onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: availableMeals,
    ); // Oletuksena kategoriat
    var activePageTitle = 'Categories';

    // Jos indeksi onkin 1, eli suosikit
    if (_selectedPageIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
