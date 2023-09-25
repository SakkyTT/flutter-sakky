import 'package:flutter/material.dart';

class Child1 extends StatefulWidget {
  Child1(this.switch1, this.switch2, this.switch3, {super.key});

  void Function() switch1;
  void Function() switch2;
  void Function() switch3;

  @override
  State<Child1> createState() {
    return _Child1State();
  }
}

class _Child1State extends State<Child1> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Child 1'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: widget.switch1,
                child: const Text('Child 1'),
              ),
              ElevatedButton(
                onPressed: widget.switch2,
                child: const Text('Child 2'),
              ),
              ElevatedButton(
                onPressed: widget.switch3,
                child: const Text('Child 3'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
