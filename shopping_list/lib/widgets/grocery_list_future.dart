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
  var _isLoading = true;
  String? _error = null;

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
        // flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app
        'flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app',
        'shopping-list.json');

    // get, post, delete jne heittää tälläisen virheen joissain tilanteissa
    // meidän pitää koodissa hallita se virhe: try{}catch(){}
    // throw Exception('An error occured!');

    // tämä pitäisi lisätä jokaiseen paikkaan, jossa käytetään http metodeja
    try {
      final response = await http.get(url);
      print(response.statusCode); // 404

      // Jos statuscode on 400 tai enemmän, on tapahtunut virhe
      // Lisäksi tässä voisi tarkemmin ilmaista, mikä koodi tuli tarkalleen
      if (response.statusCode >= 400) {
        setState(() {
          _error = 'Failed to fetch data. Please try again later!';
        });
        // logError(response.statusCode);
      }

      var testForNull = json.decode(response.body);

      if (testForNull == null) {
        // if (response.body == 'null') {
        setState(() {
          _isLoading = false;
        });
        return;
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
      // await Future.delayed(Duration(seconds: 4)); Pysäyttää suorituksen
      setState(() {
        _groceryItems = loadedItems;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _error = 'Something went wrong! $error';
      });
    }
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
    Widget content = const Center(
      child: Text('No items added yet.'),
    );

    // Jos ladataan tietokannasta dataa
    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            // ListTile widgettiin generoidaan tuotteet dummy_items tiedostosta
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(_error!),
      );
    }

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
      body: content,
    );
  }
}
