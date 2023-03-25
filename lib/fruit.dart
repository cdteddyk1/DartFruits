import 'package:flutter/material.dart';

class Fruit {
  final int id;
  final String name;
  final Color color;
  final double price;
  final String season;
  final int stock; // Ajout de la propriété stock
  final String image;
  int quantity;
static Color hexToColor(String hexString) {
    return Color(int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
  }
  Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.price,
    required this.season,
    required this.stock,
    required this.image,
    this.quantity = 0,
  });

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json['id'],
      name: json['name'],
      color: hexToColor(json['color']),
      price: double.parse(json['price'].toString()),
      season: json['season'],
      stock: json['stock'], // Utilisation de la propriété stock
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color.toString(),
        'price': price,
        'season': season,
        'stock': stock, // Utilisation de la propriété stock
        'image': image,
      };
}
