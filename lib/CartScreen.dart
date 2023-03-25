import 'package:flutter/material.dart';
import 'fruit.dart';

class CartScreen extends StatefulWidget {
  final List<Fruit> fruits;
  final double totalPrice;
  final Function(double) onRemoveFromTotalPrice;
  final Function(int, Fruit) onRemoveFruit;
  final Function() remoteAllFruit;

    const CartScreen({
    Key? key,
    required this.fruits,
    required this.totalPrice,
    required this.onRemoveFromTotalPrice,
    required this.onRemoveFruit,
    required this.remoteAllFruit,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {

    final List<Fruit> filteredFruits =
    widget.fruits.where((fruit) => fruit.quantity > 0).toList();
    return Scaffold(
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
                        '${widget.totalPrice} €',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          widget.remoteAllFruit();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ),
      body: filteredFruits.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: filteredFruits.length,
              itemBuilder: (BuildContext context, int index) {
                final fruit = filteredFruits[index];
                return ListTile(
                  leading: Image.asset(
                    'fruits/${fruit.name.toLowerCase()}.png',
                    width: 32,
                  ),
                  title: Text('${fruit.name} ${fruit.quantity} x'),
                  trailing: IconButton(
                    onPressed: () {
                      widget.onRemoveFruit( index, fruit);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                );
              },
            ),
    );
  }
}