import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bastah/models/cart_item.dart';
import 'package:flutter/material.dart'; // For ChangeNotifier
import 'package:bastah/services/product_service.dart'; // Import ProductService
import 'package:bastah/models/product.dart';

class CartService extends ChangeNotifier {
  static const String _cartKey = 'cartItems';
  List<CartItem> _cartItems = [];
  final ProductService _productService = ProductService(); // Instance of ProductService

  List<CartItem> get cartItems => _cartItems;

  CartService() {
    _loadCartItems();
  }

  Future<void> _loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      final List<dynamic> decodedData = json.decode(cartString);
      _cartItems = decodedData.map((item) => CartItem.fromJson(item)).toList();
    }
    notifyListeners();
  }

  Future<void> _saveCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = json.encode(_cartItems.map((item) => item.toJson()).toList());
    await prefs.setString(_cartKey, encodedData);
  }

  void addToCart(String productId) {
    int index = _cartItems.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(productId: productId, quantity: 1));
    }
    _saveCartItems();
    notifyListeners();
  }

  void removeFromCart(String productId) {
    _cartItems.removeWhere((item) => item.productId == productId);
    _saveCartItems();
    notifyListeners();
  }

  void updateCartItemQuantity(String productId, int quantity) {
    int index = _cartItems.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      if (quantity > 0) {
        _cartItems[index].quantity = quantity;
      } else {
        _cartItems.removeAt(index);
      }
      _saveCartItems();
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    _saveCartItems();
    notifyListeners();
  }

  // Calculate total amount by fetching product prices
  Future<double> get totalAmount async {
    double total = 0.0;
    for (var item in _cartItems) {
      Product? product = await _productService.getProductById(item.productId);
      if (product != null) {
        total += product.price * item.quantity;
      }
    }
    return total;
  }
}
