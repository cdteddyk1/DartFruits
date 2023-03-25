import 'package:flutter/material.dart';
import 'dart:math';
import 'cart_page.dart';
import 'fruit_page.dart';
import 'fruit.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<List<Fruit>> fetchFruits() async {
  try {
    final response = await Dio().get('https://fruits.shrp.dev/items/fruits');
    final List<Map<String, dynamic>> fruitsJson =
        List<Map<String, dynamic>>.from(response.data['data']);
    List<Fruit> fruits =
        fruitsJson.map((fruitJson) => Fruit.fromJson(fruitJson)).toList();

    return fruits;
  } catch (error) {
    print(error);
    throw Exception('Failed to load fruits');
  }
}

class _MyAppState extends State<MyApp> {
  final random = Random();
  int currentIndex = 0;

  double _totalPrice = 0.0;

  List<Fruit> _fruits = [];
  bool _isLoading = true;

  void addToTotalPrice(double price, Fruit fruit) {
    setState(() {
      _totalPrice += price;
      fruit.quantity++;
    });
  }

  void removeFromTotalPrice(double price) {
    setState(() {
      _totalPrice -= price;
    });
  }

  void removeFruit(int index, Fruit fruit) {
    setState(() {
      _totalPrice -= fruit.price;
      fruit.quantity--;
    });
  }

  void onAddFruit(int index, Fruit fruit,double price) {
    setState(() {
      _totalPrice += fruit.price;
      fruit.quantity++;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchFruits().then((fruits) {
      setState(() {
        _fruits = fruits;
        _isLoading = false;
      });
    });
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
              body: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _fruits.length,
                      itemBuilder: (BuildContext context, int index) {
                        final fruit = _fruits[index];
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${fruit.name} ${fruit.quantity} x'),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart),
                                onPressed: () {
                                  addToTotalPrice(fruit.price, fruit);
                                },
                              ),
                            ],
                          ),
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
                  if (index == 1) {
                    Navigator.pushNamed(context, '/panier');
                  } else {
                    setState(() {
                      currentIndex = index;
                    });
                  }
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
