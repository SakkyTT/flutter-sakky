import 'package:flutter/material.dart';

// Lisätään google fonts paketti
import 'package:google_fonts/google_fonts.dart';

final colorSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 99, 9, 245),
  background: const Color.fromARGB(255, 49, 59, 45),
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorSchema.background,
  colorScheme: colorSchema,
  textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
    titleSmall: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.ubuntuCondensed(
      fontWeight: FontWeight.bold,
    ),
  ),
);

// 1. Model, luokalle "Place", jossa yksi property title
// 2. riverpod (meals projekti), jossa dynaaminen Places lista
// 3. Sivu(Screen), joka generoi riverpod datan sisällön
// 4. Sivu(Screen), jossa lisätään objekteja riverpod dataan
// 5. Klikataan jotain places objektia, näytetään uusi sivu(screen): places_details

// 1kpl model, 1kpl riverpod provider, 3kpl screen widgets, ? kpl widgetejä

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'My Places',
      theme: theme,
      home: tähänWidgetScreen,
    );
  }
}
