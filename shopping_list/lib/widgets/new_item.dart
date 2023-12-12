// Tässä tiedostossa on form, jolla käyttäjä voi lisätä
// uusia tuotteita ostoslistaan

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/category.dart';
import 'package:shopping_list/models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;
  var _isSending = false;

  void _saveItem() async {
    // Suoritetaan kaikkki validoinnit
    if (_formKey.currentState!.validate()) {
      // Tallennetaan vain, jos tuli true validoinnista
      _formKey.currentState!.save(); // Suoritetaan save() inputeissa
      setState(() {
        _isSending = true;
      });
      final url = Uri.https(
          // flutter-test-2-b1504-default-rtdb.europe-west1
          'flutter-test-2-b1504-default-rtdb.europe-west1.firebasedatabase.app',
          'shopping-list.json');
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.title,
          },
        ),
      ); //.then((value) => null);

      final Map<String, dynamic> resData = json.decode(response.body);

      print(response.statusCode);
      print(response.body);

      if (!context.mounted) {
        // Lopetetaan suoritus, jos contextin widget ei ole enää aktiivinen
        return;
      }
      await Future.delayed(Duration(seconds: 4));
      // Navigator.of(context).pop();
      Navigator.of(context).pop(
        // Luodaan uusi GroceyItem objekti, joka palautetaan pop mukana
        // GroceryList näkymään (missä push tapahtui)
        GroceryItem(
          //id: DateTime.now().toString(), // Placeholder id
          id: resData['name'], // id tulee vastauksena palvelimelta
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, // avaimen perusteella suoritetaan operaatioita
          child: Column(
            children: [
              // ei TextField()
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: (value) {
                  // if tarkistaa, onko käyttäjän syöttämä data hyväksyttävää
                  // value on data inputissa
                  //       <= null
                  //   "" <= empty
                  // "   " <= ei empty
                  // "  j  ".trim() <= .length == 1
                  if (value == null || // ei null
                      value.isEmpty || // ei tyhjä
                      value.trim().length <= 1 || // kaksi tai enemmän merkkejä
                      value.trim().length > 50 /* alle 50 merkkiä*/) {
                    return "Must be between 2 and 50 characters"; // On virhe
                  }
                  return null; // Ei ole virhettä
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                  // ei tarvita setState
                  // _enteredName muuttujan arvoa ei näytetä käyttäjlle
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      initialValue: _enteredQuantity
                          .toString(), // string muodossa, vaikka siinä on luku
                      validator: (value) {
                        if (value == null || // ei null
                            value.isEmpty || // ei tyhjä
                            int.tryParse(value) ==
                                null || // null == parse epäonnistui
                            int.tryParse(value)! <= 0 /* alle 50 merkkiä*/) {
                          return "Must be a valid, positive number."; // On virhe
                        }
                        return null; // Ei ole virhettä
                      },
                      onSaved: (value) {
                        // Suoritetaan validator ensin, joten value ei voi olla null
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      items: [
                        // for silmukka listan sisällä
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(category.value.title),
                              ],
                            ),
                          ),
                      ],
                      onChanged: (data) {
                        // Ei tarvitse setState
                        _selectedCategory = data!;
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              // Nappi rivi "reset" "save item"
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _isSending
                        ? null // null, nappi ei ole enää aktiivinen (UI päivittyy)
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
