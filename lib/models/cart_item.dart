class CartItem {
  final int productId;
  final int quantity;
  final Map<String, dynamic>? product; // raw product data if provided

  CartItem({required this.productId, required this.quantity, this.product});
  factory CartItem.fromJson(Map<String, dynamic> j) => CartItem(
    productId: j['product_id'],
    quantity: j['quantity'],
    product: j['product'],
  );
}
