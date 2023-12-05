// Tässä tiedostossa on form, jolla käyttäjä voi lisätä
// uusia tuotteita ostoslistaan

import 'package:flutter/material.dart';

import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';

  void _saveItem() {
    // Suoritetaan kaikkki validoinnit
    if (_formKey.currentState!.validate()) {
      // Tallennetaan vain, jos tuli true validoinnista
      _formKey.currentState!.save(); // Suoritetaan save() inputeissa
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
                      initialValue:
                          '1', // string muodossa, vaikka siinä on luku
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
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(items: [
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
                    ], onChanged: (data) {}),
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
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: const Text('Add Item'),
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
