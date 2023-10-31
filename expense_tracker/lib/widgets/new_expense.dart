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
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController, // linkitetään TextField ja controller
            maxLength: 50,
            // keyboardType: TextInputType.text, // oletus
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
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
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
