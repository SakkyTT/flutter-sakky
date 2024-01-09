import 'dart:io';

import 'package:uuid/uuid.dart';

// Luodaan paketista Uudi objekti
const uuid = Uuid();

class Place {
  Place({required this.title, required this.image}) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
}
