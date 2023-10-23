import 'package:flutter/material.dart';

import 'package:elokuvat/categories.dart';
import 'package:elokuvat/movies_by_categories.dart';

//                                  0         1         2         3
const List<String> categories = ['Action', 'Drama', 'Comedy', 'Horror'];

class Movies extends StatefulWidget {
  const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  // State - luokkamuuttuja - property
  var activeScreen = 'categories';

  var category = '';

  void chooseCategory(int index) {
    setState(() {
      activeScreen = 'movies-by-category';
      category = categories[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget;

    if (activeScreen == 'movies-by-category') {
      screenWidget = MoviesByCategory(category);
    } else {
      screenWidget = Categories(
        categories,
        onSelectCategory: chooseCategory,
      );
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: screenWidget,
        ),
      ),
    );
  }
}
