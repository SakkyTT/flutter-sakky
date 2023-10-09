import 'package:flutter/material.dart';

class MoviesByCategory extends StatelessWidget {
  const MoviesByCategory(this.category, {super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Olet valinnut kategorian $category'),
    );
  }
}
