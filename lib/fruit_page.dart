import 'package:flutter/material.dart';
import 'fruit.dart';
class FruitPage extends StatelessWidget {
  const FruitPage({
    Key? key,
    required this.fruit,
    required this.onAddToCart,
    required this.onAddFruit,
  }) : super(key: key);

  final Fruit fruit;
  final void Function(double) onAddToCart;
  final Function(int) onAddFruit;
  
  // ...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fruit.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                'fruits/${fruit.name.toLowerCase()}.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ${fruit.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onAddToCart(fruit.price);
                  onAddToCart(fruit.price);
                  fruit.quantity++;
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}