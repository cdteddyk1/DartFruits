import 'package:flutter/material.dart';

class Fruit {

  
  
  final String name;
  final Color color;
  final double price;
  final int index;
  int quantity;

  Fruit({
    required this.name,
    required this.color,
    required this.price,

    required this.index,
    this.quantity = 0,
  });
}