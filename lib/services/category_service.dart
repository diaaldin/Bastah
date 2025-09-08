import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:bastah/models/category.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class CategoryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Get all categories
  Stream<List<Category>> getCategories() {
    return _firestore.collection('categories').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromFirestore(doc)).toList();
    });
  }

  // Add a new category
  Future<void> addCategory(Category category) async {
    await _firestore.collection('categories').add(category.toFirestore());
  }

  // Update an existing category
  Future<void> updateCategory(Category category) async {
    await _firestore.collection('categories').doc(category.id).update(category.toFirestore());
  }

  // Delete a category
  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  // Upload image to Firebase Storage
  Future<String> uploadImage(XFile image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('category_images').child(fileName);
    UploadTask uploadTask = ref.putFile(File(image.path));
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
