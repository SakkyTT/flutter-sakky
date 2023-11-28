import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals/screens/tabs.dart';
// import 'package:meals/screens/meals.dart';

import 'package:meals/data/dummy_data.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main(List<String> args) {
  runApp(
    // Paketoidaan koko app riverpod widgetillä, jotta sen ominaisuudet ovat
    // saatavilla. Ei ole aina pakko paketoida koko appia, voisi olla vain
    // tietty osa appia, joka tarvitsee jaettua dataa.
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}

// Riverpod
// 1. luodaan providers tiedostoja, jossa on data ja keino muokata dataa
// 2. Widgetit ovat "Consumers", jotka käyttävät providerin dataa ja metodeja
