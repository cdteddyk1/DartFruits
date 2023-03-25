import 'package:flutter/material.dart';

class Fruit {

  
  
  final String name;
  final Color color;
  final double price;
  final String saison;
  int quantity;
  final int index;


  Fruit({
    required this.name,
    required this.color,
    required this.price,
    required this.saison,
    this.quantity = 0,
    required this.index,
  });
}