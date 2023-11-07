import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

// Tästä tiedostosta alkaa widget puu

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // Lista käyttäjän ostoksista
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'Jauheliha 200g',
        amount: 2.99,
        date: DateTime.now().subtract(const Duration(days: 1)),
        category: Category.food),
    Expense(
        title: 'Theater',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        useSafeArea: true, // Ei käytetä käyttöliittymän tilaa (kamera, jne)
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  // Täällä funktio, joka suorittaa listaan tallennuksen, tämä funktio
  // lähetetään parametrinä widgettiin, jossa käyttäjän data saadaan
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    // Poiston peruutus
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      // SnackBar on tapa ilmoittaa käyttäjälle viestejä Flutterissa
      // Tässä tapauksessa annetaan ilmoitus ostoksen poistosta ja nappi,
      // jolla ostos voidaan palauttaa.
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              // Datan poiston peruutus
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    final width =
        MediaQuery.of(context).size.width; // UI näytön koon perusteella

    Widget mainContent = const Center(
      child: Text('No Expenses found. Start ading some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // iOS oletus asetus
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
        ],
      ),
      // Tutkitaan laitteen leveys ja sen perusteella luodaan Column tai Row
      body: width < 600 // Ternary operaatio
          ? Column(
              // TRUE - Päällekkäin
              children: [
                // AppBar ei tule tänne
                //const Text('Chart goes here'),
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : Row(
              // FALSE - Vierekkäin
              children: [
                // AppBar ei tule tänne
                //const Text('Chart goes here'),
                Expanded(
                  child: Chart(expenses: _registeredExpenses),
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            ),
    );
  }
}

// Size constraints ja preferences Widgeteillä
// Nämä määrittelevät Widgetin koon
// Constraint tarkoittaa vanhemman rajoituksia sen lapsille
// Preference tarkoittaa widgetin omaa käyttäytymistä
// Jokaisella widgetillä on sen omat preferences (kuinka se widget itse haluaa asettua)
//    ja sen constraints sen lapsille (kuinka widget rajoittaa sen lapsiaan.)

// Jos on vanhempi widget (esim column) ja sillä lapsi (esim. listview)
// Column ei rajoita sen lapsien korkeutta ja listview preference on ääretön
// korkeus. Lopputuloksena on ääretön korkeus listview widgetille, joka on mah-
// doton toteuttaa.

// Column preferences: width: niin paljon kuin sen lapset tarvitsevat
//                    height: ääretön

// Row preferences:    width: ääretön
//                    height: niin paljon kuin sen lapset tarvitsevat
//

// Vanhempi jolla on ääretön constraint ja lapsi jolla on ääretön preference
// Väliin pitää laittaa Expanded widget, joka katkaisee äärettömien ketjun.
