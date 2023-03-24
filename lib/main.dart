import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final random = Random();

  final List<Fruit> _fruits = [
    Fruit(name: 'Pomme', color: const Color.fromARGB(255, 128, 63, 58), price: 1.0), // rouge
    Fruit(name: 'Pomme', color: const Color.fromARGB(255, 255, 0, 0), price: 2.5), // rouge
    Fruit(name: 'Banane', color: const Color.fromARGB(255, 255, 255, 0), price: 1.3), // jaune
    Fruit(name: 'Orange', color: const Color.fromARGB(255, 255, 165, 0), price: 1.7), // orange
    Fruit(name: 'Raisin', color: const Color.fromARGB(255, 128, 0, 128), price: 0.3), // violet
    Fruit(name: 'Ananas', color: const Color.fromARGB(255, 255, 255, 0), price: 1.9), // jaune et vert
    Fruit(name: 'Fraise', color: const Color.fromARGB(255, 255, 0, 0), price: 1.1), // rouge
    Fruit(name: 'Cerise', color: const Color.fromARGB(255, 128, 0, 0), price: 1.8), // rouge foncé
    Fruit(name: 'Kiwi', color: const Color.fromARGB(255, 139, 195, 74), price: 1.5), // vert et marron
    Fruit(name: 'Poire', color: const Color.fromARGB(255, 173, 255, 47), price: 3.0), // vert et marron
    Fruit(name: 'Mangue', color: const Color.fromARGB(255, 255, 193, 37), price: 2.8),
  ];

  double _totalPrice = 0.0; // initialisation du prix total

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits',
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Price of fruits'),
              Text('\$' + _totalPrice.toStringAsFixed(2)),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: _fruits.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(_fruits[index].name),
              tileColor: _fruits[index].color,
              onTap: () {
                setState(() {
                  _totalPrice += _fruits[index].price;
                });
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _fruits.add(_fruits[random.nextInt(_fruits.length)]);
            });
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class Fruit {
  final String name;
  final Color color;
  final double price;

  Fruit({required this.name, required this.color, required this.price});
}