import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

// Compile time data, näiden muuttaminen vaatii sovelluksen uudelleen tekemisen
enum Category { food, travel, leisure, work }

const categoryIcons = {
  Category.food: Icon(Icons.lunch_dining),
  Category.travel: Icon(Icons.flight_takeoff),
  Category.leisure: Icon(Icons.theater_comedy),
  Category.work: Icon(Icons.work)
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
