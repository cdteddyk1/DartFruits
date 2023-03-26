import 'dart:convert';

import 'package:flutter/material.dart';
import 'fruit.dart';
import 'package:http/http.dart' as http;

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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  void _inscription(String email, String password) async {
    final url = Uri.parse('https://fruits.shrp.dev/users');
    final response = await http.post(
      url,
      body: <String, String>{
        'email': email,
        'password': password,
      },
    );
    if (response.statusCode == 204) {
      // Si la requête est réussie, affichez un message de succès
      print("inscription réussie");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inscription réussie'),
        ),
      );
    } else {
      // Si la requête échoue, affichez un message d'erreur avec le code d'erreur
      print("inscription échoué");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur Inscription'),
        ),
      );
    }
  }
    void _connection(String email, String password) async {
    final url = Uri.parse('https://fruits.shrp.dev/auth/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: {
        jsonEncode({'email': email, 'password': password})
      },
    );

     if (response.statusCode == 200) {
      print("connection réussie");
      // Si la requête est réussie, affichez un message de succès
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Connection réussie'),
        ),
      );
    } else {
       print("connection échoué");
      // Si la requête échoue, affichez un message d'erreur avec le code d'erreur
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur Connection'),
        ),
      );
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final List<Fruit> filteredFruits =
        widget.fruits.where((fruit) => fruit.quantity > 0).toList();
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
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
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
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
                              widget.onRemoveFruit(index, fruit);
                              widget.onRemoveFromTotalPrice(fruit.price);
                            },
                            icon: const Icon(Icons.remove_circle),
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                            ),
                            validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username VIDE';

                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            
                          labelText: 'Password',
                          // Optionally, you can customize other properties such as the border and label style
                        ),
                          // The validator receives the text that the user has entered.
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password VIDE';
                              
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Si le formulaire est valide, envoyer les données à l'API
                              _inscription(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          child: const Text('Inscription'),
                        ),    
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // Si le formulaire est valide, envoyer les données à l'API
                              _connection(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          child: const Text('Connection'),
                        ),    
                        ),
                      ],
                    ),
                  )
                ),
                ],
              )
            ),
  );
  }
}
