import 'package:flutter/material.dart';
import 'fruit.dart';


class CartPage extends StatelessWidget {
  final List<Fruit> fruits;
  final double totalPrice;
  final Function(double) onRemoveFromTotalPrice;
  final Function(int) onRemoveFruit;

  const CartPage(
    {
     
    Key? key,
    required this.fruits,
    required this.totalPrice,
    required this.onRemoveFromTotalPrice,
    required this.onRemoveFruit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter the fruits list to only include those with a quantity greater than zero
 final List<Fruit> filteredFruits = fruits.where((fruits) => fruits.quantity > 0).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: filteredFruits.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : ListView.builder(
              itemCount: filteredFruits.length,
              itemBuilder: (BuildContext context, int index) {
                final fruits = filteredFruits[index];
                return ListTile(
                  leading: Image.asset('fruits/${fruits.name.toLowerCase()}.png',
                      width: 32),
                  title: Text('${fruits.name} ${fruits.quantity} x'),
                  trailing: IconButton(
                    onPressed: () {
                      onRemoveFruit(fruits.index);
                      onRemoveFromTotalPrice(fruits.price * fruits.quantity);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total: \$${totalPrice.toStringAsFixed(2)}'),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure you want to checkout?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('CANCEL'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Checkout successful'),
                                ),
                              );
                            },
                            child: const Text('CHECKOUT'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}