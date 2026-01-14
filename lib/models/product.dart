class Product {
  final int id;
  final String title;
  final double price;
  final String? image;

  Product({required this.id, required this.title, required this.price, this.image});

  factory Product.fromJson(Map<String, dynamic> j) => Product(
    id: j['id'],
    title: j['title'] ?? j['name'] ?? '',
    price: (j['price'] != null) ? double.tryParse(j['price'].toString()) ?? 0.0 : 0.0,
    image: j['image'],
  );
}
