// Tähän näkymään saavutaan places.dart näkymästä
// Tässä näytetään tietyn paikan tiedot (title, image, location, jne)
// Tietojen näyttämistä varten tarvitaan parametrinä jokin place objekti

import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen(this.place, {super.key});

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
      // Stack, laittaa widgettejä päällekkäin (z-akselilla)
      // Ensimmäisenä on alin widgetti
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
        ],
      ),
    );
  }
}
