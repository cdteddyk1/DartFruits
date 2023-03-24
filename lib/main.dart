import 'package:flutter/material.dart';
import 'dart:math';
import 'fruit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final random = Random();

  final List<Fruit> _fruits = [
    Fruit(
        name: 'Pomme', color: const Color.fromARGB(255, 255, 0, 0), price: 2.5),
    Fruit(
        name: 'Banane',
        color: const Color.fromARGB(255, 255, 255, 0),
        price: 1.3),
    Fruit(
        name: 'Orange',
        color: const Color.fromARGB(255, 255, 165, 0),
        price: 1.7),
    Fruit(
        name: 'Ananas',
        color: const Color.fromARGB(255, 255, 255, 0),
        price: 1.9),
    Fruit(
        name: 'Fraise',
        color: const Color.fromARGB(255, 255, 0, 0),
        price: 1.1),
    Fruit(
        name: 'Kiwi',
        color: const Color.fromARGB(255, 139, 195, 74),
        price: 1.5),
    Fruit(
        name: 'Poire',
        color: const Color.fromARGB(255, 173, 255, 47),
        price: 3.0),
    Fruit(
        name: 'Mangue',
        color: const Color.fromARGB(255, 255, 193, 37),
        price: 2.8),
  ];

  double _totalPrice = 0.0;

  void addToTotalPrice(double price) {
    setState(() {
      _totalPrice += price;
    });
  }

  void removeFromTotalPrice(double price) {
    setState(() {
      _totalPrice -= price;
    });
  }

  void removeFruit(int index) {
    setState(() {
      _totalPrice -= _fruits[index].price;
      _fruits.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits',
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Price of fruits'),
              Text(_totalPrice.toStringAsFixed(2)),
            ],
          ),
        ),
        body: ListView.builder(
  itemCount: _fruits.length,
  itemBuilder: (BuildContext context, int index) {
    final fruit = _fruits[index];
    return ListTile(
      leading: Image.asset('fruits/${fruit.name.toLowerCase()}.png', width: 32),
      title: Text(fruit.name),
      tileColor: fruit.color,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FruitPage(
              fruit: fruit,
              onAddToCart: addToTotalPrice,
            ),
          ),
        );
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
          child: const Icon(Icons.add),
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
