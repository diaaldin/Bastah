
class Cart {
  final List<CartItem> items;

  Cart({required this.items});

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      items: (map['items'] as List)
          .map((item) => CartItem.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
    };
  }
}

class CartItem {
  final String productId;
  int quantity;

  CartItem({
    required this.productId,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}
