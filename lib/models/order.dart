import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

class Order {
  final String id;
  final String customerUid; // Added customerUid
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final List<OrderItem> items;
  final double totalAmount;
  final String paymentMethod;
  final String status;
  final Timestamp createdAt;

  Order({
    required this.id,
    required this.customerUid, // Added customerUid
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Order(
      id: doc.id,
      customerUid: data['customerUid'], // Added customerUid
      customerName: data['customer_name'],
      customerPhone: data['customer_phone'],
      customerAddress: data['customer_address'],
      items: (data['items'] as List)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      totalAmount: data['total_amount'].toDouble(),
      paymentMethod: data['payment_method'],
      status: data['status'],
      createdAt: data['created_at'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerUid': customerUid, // Added customerUid
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'customer_address': customerAddress,
      'items': items.map((item) => item.toMap()).toList(),
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'status': status,
      'created_at': createdAt,
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      productId: map['product_id'],
      quantity: map['quantity'],
      price: map['price'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}