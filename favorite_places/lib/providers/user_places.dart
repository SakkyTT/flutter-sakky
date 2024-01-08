import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  // const [] on oletus data, joka määritellään
  // Siinä voisi olla oletuksena jotakin muuta
  // Huomioi, että käytetään const, riverpod data on immutable
  // joka tarkoittaa, että dataa/objektia ei muokata vaan luodaan aina
  // uusi objekti (Esim lista)
  UserPlacesNotifier() : super(const []);

  // "muokataan" state, korvataan vanha lista uudella listalla
  void addPlace(String title) {
    final newPlace = Place(title: title);
    // Tallennetaan state propertyyn uusi lista, jossa on uusi place ja vanhat place
    state = [newPlace, ...state];
  }
}

// Tämän (provider) kautta käsitellään dataa
final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
