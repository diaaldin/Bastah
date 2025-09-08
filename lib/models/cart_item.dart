
class CartItem {
  final String productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  // Convert a CartItem to a JSON map
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };

  // Create a CartItem from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json['productId'],
        quantity: json['quantity'],
      );
}
