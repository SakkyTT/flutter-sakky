// Malli, jonka pohjalta generoidaan kategorioita

import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, // Orange on oletusväri, jos ei sitä määritellä
  });

  final String id;
  final String title;
  final Color color;
}
