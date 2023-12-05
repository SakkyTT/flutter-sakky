import 'package:flutter/material.dart';

enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

class Category {
  // Positional parameter / named parameter
  // Sijainti parametrit ovat aina pakollisia
  const Category(
    this.title,
    this.color,
  );

  final String title;
  final Color color;
}
