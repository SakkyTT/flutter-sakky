import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/data/dummy_data.dart';

final mealsProvider = Provider((ref) {
  // Tarjotaan staattista dummyMeals dataa
  return dummyMeals; // red.watch(mealsProvider) palauttaa tämän datan
}); // riverpod paketista