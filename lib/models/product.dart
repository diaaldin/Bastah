import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

class Product {
  final String id;
  final String categoryId;
  final Map<String, String> name;
  final Map<String, String> description;
  final double price;
  final int stock;
  final List<String> images;

  Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.images,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Product(
      id: doc.id,
      categoryId: data['category_id'],
      name: Map<String, String>.from(data['name']),
      description: Map<String, String>.from(data['description']),
      price: data['price'].toDouble(),
      stock: data['stock'],
      images: List<String>.from(data['images']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'images': images,
    };
  }
}