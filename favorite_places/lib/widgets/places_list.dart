// Tämä widget näkyy screen/places.dart tiedostossa

// widget saa parametrina listan place objekteja
// ja palauttaa ne ListView.builder rakenteessa

import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';

import 'package:favorite_places/models/place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    // Ei ole yhtään paikkaa olemassa
    if (places.isEmpty) {
      // Huom! täällä on return!
      // Funktion suoritus loppuu, kun return tapahtuu
      return Center(
        child: Text(
          'No places added yet',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    }

    // Jos dataa, palautetaan tämä widget rakenne
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (ctx, index) => ListTile(
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: FileImage(places[index].image),
        ),
        title: Text(
          places[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        // Tässä onTap siirtää place_details sivulle
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailsScreen(places[index]),
            ),
          );
        },
      ),
    );
  }
}
