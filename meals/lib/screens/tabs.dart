import 'package:flutter/material.dart';

import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0; // Tämän perusteellä näytetään oikea sivu
  final List<Meal> _favoriteMeals = [];

  // Funktio / metodi
  // Kaikki metodit ovat funktioita,
  // mutta vain luokan funktiot ovat metodeja
  // Jos ateria ei ole suosikki, lisätän se suosikkeihin
  // Jos ateria on jo suosikki, otetaan se pois
  void _toggleMealFavoriteStatus(Meal meal) {
    // Tutkitaan onko ateria jo listassa
    final isExisting = _favoriteMeals.contains(meal);

    // Suoritetaan poisto / lisäys
    // if (_favoriteMeals.contains(meal)) {
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      }); // Kuinka saadaan aterian nimi lisättyä viestiin?
      _showInfoMessage("${meal.title} removed from favorites!");
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage("Marked as a favorite!");
    }
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars(); // Poistetaan vanha viesti
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _selectPage(index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    ); // Oletuksena kategoriat
    var activePageTitle = 'Categories';

    // Jos indeksi onkin 1, eli suosikit
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(),
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
