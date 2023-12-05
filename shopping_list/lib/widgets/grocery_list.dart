import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';
import 'package:shopping_list/widgets/new_item.dart';

//                       refactor -> statefulWidget -> saadaan context
class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  // Tässä metodissa siirrytään NewItem näkymään
  void _addItem() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
  }

  //   Kuinka context saadaan parametrinä
  // void _addItem(BuildContext context) {
  //   Navigator.of(context)
  // }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
          // ListTile widgettiin generoidaan tuotteet dummy_items tiedostosta
          title: Text(groceryItems[index].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[index].category.color,
          ),
          trailing: Text(
            groceryItems[index].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
