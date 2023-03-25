import 'package:flutter/material.dart';
import 'fruit.dart';

class FruitPage extends StatefulWidget {
  const FruitPage({
    Key? key,
    required this.fruit,
    required this.onAddFruit,
    
  }) : super(key: key);

  final Fruit fruit;
  final Function(int, Fruit,double) onAddFruit;

  @override
  State<StatefulWidget> createState() => _FruitPageState();
}

class _FruitPageState extends State<FruitPage> {
  int _quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fruit.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                'fruits/${widget.fruit.name.toLowerCase()}.png',
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Price: ${widget.fruit.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            Text('Saison: ${widget.fruit.season}', style: const TextStyle(fontSize: 20),),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _quantity++;
                  widget.onAddFruit(widget.fruit.id, widget.fruit, widget.fruit.price);

                });
              },
              child: const Text('Add to Cart'),
            ),
            const SizedBox(height: 16),
            Text(
              'Quantity: $_quantity',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}