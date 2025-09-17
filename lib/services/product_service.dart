import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:bastah/models/product.dart';
import 'dart:io';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get all products
  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Product.fromFirestore(doc)).toList();
    });
  }

  // Get a single product by ID
  Future<Product?> getProductById(String productId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('products')
          .doc(productId)
          .get();
      if (doc.exists) {
        return Product.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      log('Error getting product by ID: $e');
      return null;
    }
  }

  // Add a new product
  Future<Product> addProduct(Product product, List<File> imageFiles) async {
    DocumentReference docRef = _firestore.collection('products').doc();

    List<String> imageUrls = [];
    for (var imageFile in imageFiles) {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
      Reference ref = _storage.ref().child('product_images/$fileName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      imageUrls.add(downloadUrl);
    }

    Product newProduct = Product(
      id: docRef.id,
      categoryId: product.categoryId,
      name: product.name,
      description: product.description,
      price: product.price,
      stock: product.stock,
      images: imageUrls, // Use uploaded image URLs
    );

    await docRef.set(newProduct.toFirestore());
    return newProduct;
  }

  // Update an existing product
  Future<Product> updateProduct(
    Product product, {
    List<File>? newImageFiles,
  }) async {
    List<String> updatedImageUrls = product.images;

    if (newImageFiles != null && newImageFiles.isNotEmpty) {
      updatedImageUrls = []; // Clear old images
      for (var imageFile in newImageFiles) {
        String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        Reference ref = _storage.ref().child('product_images/$fileName');
        UploadTask uploadTask = ref.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();
        updatedImageUrls.add(downloadUrl);
      }
    }

    Product updatedProduct = Product(
      id: product.id,
      categoryId: product.categoryId,
      name: product.name,
      description: product.description,
      price: product.price,
      stock: product.stock,
      images: updatedImageUrls, // Use updated image URLs
    );

    await _firestore
        .collection('products')
        .doc(product.id)
        .update(updatedProduct.toFirestore());
    return updatedProduct;
  }

  // Delete a product
  Future<void> deleteProduct(String productId) async {
    // Optionally, delete images from storage as well
    // You would need to fetch the product first to get image URLs
    await _firestore.collection('products').doc(productId).delete();
  }
}
