import 'package:flutter/material.dart';
import 'fruit.dart';

class CartPage extends StatelessWidget {
  final List<Fruit> fruits;
  final double totalPrice;
  final Function(double) onRemoveFromTotalPrice;
  final Function(int, Fruit ) onRemoveFruit;
  final Function() remoteAllFruit;

  const CartPage({
    Key? key,
    required this.fruits,
    required this.totalPrice,
    required this.onRemoveFromTotalPrice,
    required this.onRemoveFruit,
    required this.remoteAllFruit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter the fruits list to only include those with a quantity greater than zero
    final List<Fruit> filteredFruits =
        fruits.where((fruit) => fruit.quantity > 0).toList();

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
                        ' ${totalPrice.toStringAsFixed(2)}  €',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          remoteAllFruit();
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
                      onRemoveFruit( index, fruit);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                );
              },
            ),
    );
  }
}