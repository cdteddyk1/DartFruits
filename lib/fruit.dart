import 'package:flutter/material.dart';

class Fruit {
  final int id;
  final String name;
  final Color color;
  final Country origin; // Modification de la propriété origin
  final double price;
  final String season;
  final int stock;
  final String image;
  int quantity;

  static Color hexToColor(String hexString) {
    return Color(int.parse(hexString.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Fruit({
    required this.id,
    required this.name,
    required this.color,
    required this.origin,
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
      origin: Country.fromJson(json['origin']), // Utilisation de la classe Country
      price: double.parse(json['price'].toString()),
      season: json['season'],
      stock: json['stock'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color.toString(),
        'origin': origin.toJson(), // Utilisation de la méthode toJson() de la classe Country
        'price': price,
        'season': season,
        'stock': stock,
        'image': image,
      };
}

class Country {
  final int id;
  final String name;
  final Location location;

  Country({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'location': location.toJson(),
      };
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}