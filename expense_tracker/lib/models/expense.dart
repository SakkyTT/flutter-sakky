import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

//  final formatter = DateFormat.yMd();
final formatter = DateFormat('d/M/y');

const uuid = Uuid();

// Compile time data, näiden muuttaminen vaatii sovelluksen uudelleen tekemisen
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.theater_comedy,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id; // generoidaan tässä tiedostossa, kun luodaan objekti
  final String title;
  final double amount; // Price / hinta
  final DateTime date;
  final Category
      category; // 'ruoka' <- joka paikassa pitää olla kirjoitettuna oikein

  String get formattedDate {
    return formatter.format(date);
  }
}

// Pitää sisällään kategorian ja sen kategorian kaikki ostokset
class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  // Suodattaa listan ostoksia ja tallentaa vain oikean kategorian ostokset
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) =>
                expense.category == // Vertailuoperaatio säilytetäänkö vai ei
                category)
            .toList();

  final Category category;
  final List<Expense> expenses; // jauhelija, tonnikala

  // Ostoksien summa
  double get totalExpenses {
    double sum = 0;

    // Lasketaan summa
    // for (int i = 0; i < expenses.length; i++) {}
    for (final expense in expenses) {
      // expense == jauheliha
      // expense == tonnikala
      // sum = sum + expense.amount;
      sum += expense.amount;
    }

    return sum;
  }
}
