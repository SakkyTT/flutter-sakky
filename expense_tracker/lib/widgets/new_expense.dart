import 'dart:io'; // Platform objektia varten

import 'package:flutter/cupertino.dart'; // iOS paketti
import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   // otetaan talteen uusi title-data
  //   _enteredTitle = inputValue; // inputValue on käyttäjän uusi teksti
  // } ctrl pohjassa -> k c

  // Flutterin objecti, suorittaa käyttäjän syöttämän tekstin tallentamisen
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  DateTime? _selectedDate; // Voi olla null ? <- mahdollistaa null arvon,
  // koodissa pitää varmistaa ettei sovellus kaadu
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now); //.then((value) => null); // yksi vaihtoehto

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  // Näytetään joko iOS dialog tai oletus android dialog
  void _showDialog() {
    if (Platform.isIOS) {
      // Cupertino on IOS tyylittelyn nimi
      showCupertinoDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please make sure information is entered correctly!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay...'))
                ],
              ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content:
              const Text('Please make sure information is entered correctly!'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay...'))
          ],
        ),
      );
    } // else
  } // funktio

  void _submitExpenseData() {
    final double? enteredPrice = double.tryParse(_priceController.text);
    // ==, >=, <: ovat vertailu operaatioita
    // || ja && ovat loogisia operaatioita, joilla voi yhdistää useamman vertailun
    final bool priceIsInvalid = enteredPrice == null || enteredPrice < 0;

    // Tarkistetaan käyttäjän tallentama data
    if (_titleController.text.trim().isEmpty ||
        priceIsInvalid == true ||
        _selectedDate == null) {
      // Tarkistetaan virheet
      // Näytetään virhe teksti

      _showDialog();

      return; // Päättää funktion suorituksen
    } // else {tallennus täällä}

    // Suoritetaan tallennus
    // Suorittakaa datan tallennus parent widgetin State:tiin

    // Luodaan uusi Expense objekti
    final temp = Expense(
        title: _titleController.text,
        amount: enteredPrice!,
        date: _selectedDate!,
        category: _selectedCategory);

    // Lähetetään objecti funktion parametrinä
    widget.onAddExpense(temp);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Osa widgetin elämänkaarta, suoritetaan kun widget poistuu käytöstä
    _titleController
        .dispose(); // Jos ei poisteta, voi aiheuttaa muisti vuotoa (memory leak)
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // UI asettelu Widgetillä olevan tilan perusteella
    // Tällä tavalla tehtynä, widgettiä voi käyttää eri paikoissa sovellusta
    // ja se asettuu sopivaksi tilanteen perusteella

    return LayoutBuilder(builder: (ctx, constraints) {
      // print(constraints.minWidth);
      // print(constraints.minHeight);
      // print(constraints.maxHeight);

      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + keyboardSpace),
            child: Column(
              children: [
                // Alkaa lista
                if (width >= 600) // listan if syntaksi, ei aaltosulkuja
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller:
                              _titleController, // linkitetään TextField ja controller
                          maxLength: 50,
                          // keyboardType: TextInputType.text, // oletus
                          decoration: const InputDecoration(
                            // Täällä voi rajoittaa
                            label: Text('Title'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '€ ',
                            suffixText:
                                ' \$', // escape syntaksi, koska $ osana dart kieltä
                            label: Text('Price'),
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller:
                        _titleController, // linkitetään TextField ja controller
                    maxLength: 50,
                    // keyboardType: TextInputType.text, // oletus
                    decoration: const InputDecoration(
                      label: Text('Title'),
                    ),
                  ),
                if (width >= 600) // Uusi toka rivi
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            // Tarkistetaan onko arvo null
                            return; // Lopettaa function suorituksen jos on null
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Ternary operaatio, yhden rivin if else
                            Text(
                              _selectedDate == null // Vertailu, true tai false
                                  ? 'Select Date' // ? arov jos true
                                  : formatter.format(_selectedDate!),
                            ), // : arvo jos false
                            // ! kertoo että muuttuja ei ole null (meidän vastuulla)
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                else // Vanha toka rivi
                  Row(
                    // Lisätään tähän ehdollinen widgettien tulostus
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: '€ ',
                            suffixText:
                                ' \$', // escape syntaksi, koska $ osana dart kieltä
                            label: Text('Price'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Ternary operaatio, yhden rivin if else
                            Text(
                              _selectedDate == null // Vertailu, true tai false
                                  ? 'Select Date' // ? arov jos true
                                  : formatter.format(_selectedDate!),
                            ), // : arvo jos false
                            // ! kertoo että muuttuja ei ole null (meidän vastuulla)
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                // Kolmas rivi
                if (width >= 600)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  ) // Uusi rivi
                else // Vanha rivi
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            // Tarkistetaan onko arvo null
                            return; // Lopettaa function suorituksen jos on null
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save Expense'),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
