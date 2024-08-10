class Product {
  final int id;
  final String name;
  final String description;
  final String image;
  final String brand;
  final String? subcategorie;
  final double priceSale;
  final List<dynamic> colors;
  final List<dynamic> sizes;
  final String category;
  int quantity;

  Product(
      {required this.name,
      required this.id,
      required this.brand,
      required this.description,
      required this.image,
      required this.priceSale,
      required this.colors,
      required this.sizes,
      required this.subcategorie,
      required this.category,
      required this.quantity});
}
