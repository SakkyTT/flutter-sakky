import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:favorite_places/providers/user_places.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  // Tämä objekti toimii TextField widgetin kanssa
  final _titleController = TextEditingController();

  void _savePlace() {
    final enteredText = _titleController.text;

    if (enteredText.trim().isEmpty) {
      // Ei tehdä tallennusta, lopetetaan metodin suoritus
      // Voisi olla myös jokin ilmoitus käyttäjälle
      return;
    }

    // Täällä tehdään tallennus provideriin
    // Ensin provider viittaus ja ConsumerStatefulWidget

    // käytetään read tallennus tilanteessa
    ref.read(userPlacesProvider.notifier).addPlace(enteredText);

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Yleensä Dart vapauttaa resurssit (RAM), mutta controller pitää
    // itse vapauttaa
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'),
            ),
          ],
        ),
      ),
    );
  }
}
