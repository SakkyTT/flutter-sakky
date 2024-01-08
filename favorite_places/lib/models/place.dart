import 'package:uuid/data.dart';
import 'package:uuid/uuid.dart';

// Luodaan paketista Uudi objekti
const uuid = Uuid();

class Place {
  Place({required this.title}) : id = uuid.v4();

  final String id;
  final String title;
}
