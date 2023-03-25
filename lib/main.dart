import 'package:flutter/material.dart';
import 'dart:math';
import 'cart_page.dart';
import 'fruit_page.dart';
import 'fruit.dart';


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
  int currentIndex = 0;
  final List<Fruit> _fruits = [
    Fruit(
        name: 'Pomme', color: const Color.fromARGB(255, 255, 0, 0), price: 2.5, index: 0),

    Fruit(
        name: 'Orange',
        color: const Color.fromARGB(255, 255, 165, 0),
        price: 1.7, index: 1),

    Fruit(
        name: 'Ananas',
        color: const Color.fromARGB(255, 255, 255, 0),
        price: 1.9 , index: 2),
    Fruit(
        name: 'Fraise',
        color: const Color.fromARGB(255, 255, 0, 0),
        price: 1.1 , index: 3),
    Fruit(
        name: 'Kiwi',
        color: const Color.fromARGB(255, 139, 195, 74),
        price: 1.5   , index: 4),
    Fruit(
        name: 'Poire',
        color: const Color.fromARGB(255, 173, 255, 47),
        price: 3.0 , index: 5),
    Fruit(
        name: 'Mangue',
        color: const Color.fromARGB(255, 255, 193, 37),
        price: 2.8 , index: 6),
  ];

  double _totalPrice = 0.0;
  void addToCartFruit(Fruit fruit) {
    setState(() {
      _fruits.add(fruit);
    });
    addToTotalPrice(fruit.price, fruit);
  }
    void addToTotalPrice(double price, Fruit fruit) {
      setState(() {
        _totalPrice += price;
      });
    }

    void removeFromTotalPrice(double price) {
      setState(() {
        _totalPrice -= price;
      });
    }

    addFruit(int index) {
      setState(() {
        _fruits[index].quantity++;
      });
    }

    void removeFruit(int index) {
      setState(() {
        _totalPrice -= _fruits[index].price * _fruits[index].quantity;
         _fruits[index].quantity--;
      });
    }

    void onAddFruit(int index) {
      final fruit = _fruits[index];
      _fruits[index] = Fruit(
        index: fruit.index ,
        name: fruit.name,
        color: fruit.color,
        price: fruit.price,
        quantity: fruit.quantity + 1,
      );
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Fruits',
        initialRoute: '/',
        routes: {
          '/': (context) => Scaffold(
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
                      leading: Image.asset(
                          'fruits/${fruit.name.toLowerCase()}.png',
                          width: 32),
                      title: Text('${fruit.name} ${_fruits[index].quantity} x'),
                      tileColor: fruit.color,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FruitPage(
                              fruit: fruit,
                              onAddFruit: onAddFruit,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: currentIndex,
                  onTap: (int index) {
                    Navigator.pushNamed(context, '/panier');
                  },
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Accueil'),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.shopping_cart),
                      label: 'Panier',
                    ),
                  ],
                ),
              ),
          '/panier': (context) => CartPage(
                fruits: _fruits,
                totalPrice: _totalPrice,
                onRemoveFromTotalPrice: removeFromTotalPrice,
                onRemoveFruit: removeFruit,
              ),
        },
      );
    }
  }

