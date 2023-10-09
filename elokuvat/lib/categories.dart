import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories(this.categories,
      {super.key, required this.onSelectCategory});

  final List<String> categories; // 0 1 2 3

  final void Function(int index) onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...categories.asMap().entries.map(
            (mapEntry) {
              return ElevatedButton(
                onPressed: () {
                  onSelectCategory(mapEntry.key);
                },
                child: Text(mapEntry.value),
              );
            },
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     onSelectCategory(0);
          //   },
          //   child: Text(categories[0]),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     onSelectCategory(1);
          //   },
          //   child: Text(categories[1]),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     onSelectCategory(2);
          //   },
          //   child: Text(categories[2]),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     onSelectCategory(3);
          //   },
          //   child: Text(categories[3]),
          // ),
        ],
      ),
    );
  }
}
