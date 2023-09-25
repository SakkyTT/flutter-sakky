import 'package:flutter/material.dart';
import 'package:usea_naytto_kertaus/child1.dart';
import 'package:usea_naytto_kertaus/child2.dart';
import 'package:usea_naytto_kertaus/child3.dart';

class Parent extends StatefulWidget {
  const Parent({super.key});

  @override
  State<Parent> createState() {
    return _ParentState();
  }
}

class _ParentState extends State<Parent> {
  var activeScreen = 'child-1';

  void switchScreen1() {
    // setState aiheuttaa build:n suorituksen uudelleen ja UI voi muuttua
    setState(() {
      activeScreen = 'child-1';
    });
  }

  void switchScreen2() {
    // setState aiheuttaa build:n suorituksen uudelleen ja UI voi muuttua
    setState(() {
      activeScreen = 'child-2';
    });
  }

  void switchScreen3() {
    // setState aiheuttaa build:n suorituksen uudelleen ja UI voi muuttua
    setState(() {
      activeScreen = 'child-3';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget childWidget = Child1(switchScreen1, switchScreen2, switchScreen3);

    if (activeScreen == 'child-2') {
      childWidget = Child2(switchScreen1, switchScreen2, switchScreen3);
    } else if (activeScreen == 'child-3') {
      childWidget = Child3(switchScreen1, switchScreen2, switchScreen3);
    }

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white, Colors.black],
            ),
          ),
          child: childWidget, // Jotta tämä widget voi muuttua, tarvitaan widget
        ),
      ),
    );
  }
}
