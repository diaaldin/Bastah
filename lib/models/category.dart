import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

class Category {
  final String id;
  final Map<String, String> name; // {en: English Name, ar: Arabic Name, he: Hebrew Name}
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Category.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Category(
      id: doc.id,
      name: Map<String, String>.from(data['name']),
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl,
    };
  }
}