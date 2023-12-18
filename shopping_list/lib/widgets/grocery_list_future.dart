import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';

import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/models/grocery_item.dart';

//                       refactor -> statefulWidget -> saadaan context
class GroceryListFuture extends StatefulWidget {
  const GroceryListFuture({super.key});

  @override
  State<GroceryListFuture> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryListFuture> {
  List<GroceryItem> _groceryItems = [];
  // Muuttuja, jossa on tietokannasta haetut tavarat
  late Future<List<GroceryItem>> _loadedItems;
  // late, luvataan kääntäjälle, että ladataan muuttujaan data, ennen kuin sitä
  // Käytetään build funktiossa.
  // Widget elinkaaressa initState() -> build()

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  // Koska metodi on async, se palauttaa datan future muodossa
  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        // flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app
        'flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      // setState(() {
      //   _error = 'Failed to fetch data. Please try again later!';
      // });
      // Heitetään virhe, joka käsitellään futureBuilder snapshot:ssa
      throw Exception('Failed to fetch items!');
    }

    var testForNull = json.decode(response.body);

    if (testForNull == null) {
      // Pakko määrittää palautettava datarakenne, koska metodilla on palautusarvo
      return [];
    }

    // Kaatuu, jos body == null
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = []; // Uusi väliaikainen lista
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (element) => element.value.title == item.value['category'])
          .value;

      // Täällä saadaan map, jossa on GroceryItem tarvittava data
      //                  Kokonaisuus on item muuttujassa
      //    Tässä avain         :      Tässä arvo(t)
      // {"-NlOqf2Lnxr4GJyOBjde":{"category":"Dairy","name":"Maito","quantity":15}
      // Lisätään uusi objekti suoraan listaan
      loadedItems.add(GroceryItem(
        id: item.key,
        name: item.value['name'],
        quantity: item.value['quantity'],
        category: category,
      ));
    }

    return loadedItems;
  } // _loadItems

  // Tässä metodissa siirrytään NewItem näkymään
  void _addItem() async {
    // siirretään data suoraan pop() tai riverpod
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      // Jos ei ole uutta dataa, lopetetaan funktion suoritus
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }

  //   Kuinka context saadaan parametrinä
  // void _addItem(BuildContext context) {
  //   Navigator.of(context)
  // }

  // n. 20 min aika tehdä, 18:00 käydään yhdessä läpi
  // 1. Jos lista tyhjä, näytetään jokin muu content näkymässä
  //      Esim: Text('No items added yet.');

  // 2. Tuotteita voi poistaa käyttöliittymässä (expense_tracker)
  //    Eli niitä voi "pyyhkäistä" pois

  void _removeItem(GroceryItem item) async {
    // oletuksena poistetaan tuote, otetaan indeksi talteen
    final index = _groceryItems.indexOf(item);
    setState(() {
      _groceryItems.remove(item);
    });
    final url = Uri.https(
        'flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list/${item.id}.json');

    // TODO: lisää try catch
    final response = await http.delete(url);

    // Palautetaan tuote, jos poisto epäonnistui
    if (response.statusCode >= 400) {
      setState(() {
        // Palautetaan takaisin vanhaan indeksiin
        _groceryItems.insert(index, item);
        // TODO: Näytetään virhe ilmoitus (esim snackbar)
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            // onPressed: () {
            //   _addItem(context);
            //   },
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: _loadedItems,
          builder: (context, snapshot) {
            // Täällä snapshotin tilanteen perusteella
            // generoidaan eri widget rakenne

            if (snapshot.connectionState == ConnectionState.waiting) {
              // snapshot odottaa dataa, näytetään spinner
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            // Virhetilanne
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            // Tyhjä lista, data on haettu ja siinä on tyhjä lista
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No items added yet.'),
              );
            }

            // Oletuksena lopuksi, näytetään käyttäjän tuotteet
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) => Dismissible(
                onDismissed: (direction) {
                  _removeItem(snapshot.data![index]);
                },
                key: ValueKey(snapshot.data![index].id),
                child: ListTile(
                  // ListTile widgettiin generoidaan tuotteet dummy_items tiedostosta
                  title: Text(snapshot.data![index].name),
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: snapshot.data![index].category.color,
                  ),
                  trailing: Text(
                    snapshot.data![index].quantity.toString(),
                  ),
                ),
              ),
            );
          }),

      // Tässä suoritetaan _loadItems() metodi, joka palauttaa futuurin
      // Nyt tieto haetaan tietokannasta, joka kerta kun build suoritetaan
      // Joka aiheuttaa turhaa tietokanta kutsua
      // FutureBuilder(future: _loadItems(), builder: (context, snapshot) {}),
    );
  }
}
