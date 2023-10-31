import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorSchema = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorSchema,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorSchema.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorSchema.primaryContainer,
              foregroundColor: kDarkColorSchema.onPrimaryContainer),
        ),
        scaffoldBackgroundColor: kDarkColorSchema.primaryContainer,
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDarkColorSchema.onSecondaryContainer,
                fontSize: 17,
              ),
              bodyMedium:
                  TextStyle(color: kDarkColorSchema.onSecondaryContainer),
              bodyLarge:
                  TextStyle(color: kDarkColorSchema.onSecondaryContainer),
              titleMedium: TextStyle(
                color: kDarkColorSchema.onSecondaryContainer,
              ),
            ),
        iconTheme: const IconThemeData()
            .copyWith(color: kDarkColorSchema.onPrimaryContainer),
        canvasColor: kDarkColorSchema.secondaryContainer,
        inputDecorationTheme: const InputDecorationTheme().copyWith(
          fillColor: Colors.blue, // inputin ympärillä
          prefixStyle: TextStyle(color: kDarkColorSchema.onSecondaryContainer),
          suffixStyle: TextStyle(color: kDarkColorSchema.onSecondaryContainer),
        ),
      ),

      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          // copyWith, säilyttää oletus arvot ja korvataan vain täällä määritetyt asiat
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 17,
              ),
            ),
      ),
      // themeMode: ThemeMode.system, // Oletus asetus on system
      // Jos käyttäjä haluaa asettaa dark teeman vain tähän sovellukseen
      // themeMode: ThemeMode.dark, // Suoraan dark mode
      home: const Expenses(),
    ),
  );
}
