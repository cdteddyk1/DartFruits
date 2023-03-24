import 'package:flutter/material.dart';

class Fruit {

  
  
  final String name;
  final Color color;
  final double price;
  int quantity;

  Fruit({
    required this.name,
    required this.color,
    required this.price,
    this.quantity = 0,
  });
}