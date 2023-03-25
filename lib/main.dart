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
        name: 'Pomme',
        color: const Color.fromARGB(255, 255, 0, 0),
        price: 2.5,
        index: 0,
        saison: 'hiver',
        ),
    Fruit(
        name: 'Orange',
        color: const Color.fromARGB(255, 255, 165, 0),
        price: 1.7,
        index: 1,
        saison: 'été'),

    Fruit(
        name: 'Ananas',
        color: const Color.fromARGB(255, 255, 255, 0),
        price: 1.9,
        index: 2,
        saison: 'automne'),
    Fruit(
        name: 'Fraise',
        color: const Color.fromARGB(255, 255, 0, 0),
        price: 1.1,
        index: 3,
        saison: 'printemps'),
    Fruit(
        name: 'Kiwi',
        color: const Color.fromARGB(255, 139, 195, 74),
        price: 1.5,
        index: 4,
        saison: 'été'),
    Fruit(
        name: 'Poire',
        color: const Color.fromARGB(255, 173, 255, 47),
        price: 3.0,
        index: 5,
        saison: 'hiver'),
    Fruit(
        name: 'Mangue',
        color: const Color.fromARGB(255, 255, 193, 37),
        price: 2.8,
        index: 6,
        saison: 'été'),
  ];

  double _totalPrice = 0.0;

  void addToTotalPrice(double price, int index) {
    setState(() {
      _totalPrice += price;
      _fruits[index].quantity++;
    });
  }

  void removeFromTotalPrice(double price) {
    setState(() {
      _totalPrice -= price;
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
      index: fruit.index,
      name: fruit.name,
      color: fruit.color,
      price: fruit.price,
      quantity: fruit.quantity,
      saison: fruit.saison,
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
                  children: [
                    const Expanded(
                      child: Text(
                        'Prix total  :  ',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        ' ${_totalPrice.toStringAsFixed(2)}  €',
                        textAlign: TextAlign.left,
                      ),
                    ),
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
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${fruit.name} ${_fruits[index].quantity} x'),
                        IconButton(
                          icon: const Icon(Icons.shopping_cart),
                          onPressed: () {
                            addToTotalPrice(fruit.price, index);
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FruitPage(
                            fruit: fruit,
                            onAddFruit: onAddFruit,
                            addToTotalPrice: addToTotalPrice,
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
