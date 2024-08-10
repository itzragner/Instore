import 'dart:io';

class Product {
  final String name;
  final String description;
  final double price;
  // final Brand brand;
  final File image;

  Product({
    required this.name,
    required this.description,
    required this.price,
    // required this.brand,
    required this.image,
  });
}
