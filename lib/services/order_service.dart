import 'package:bastah/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import 'package:bastah/models/order.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  // Get orders for the current customer
  Stream<List<Order>> getOrders() {
    final user = _authService.getCurrentUser();
    if (user == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('orders')
        .where('customerUid', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromFirestore(doc)).toList().cast<Order>();
    });
  }

  // Get all orders (for admin)
  Stream<List<Order>> getAllOrders() {
    return _firestore.collection('orders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Order.fromFirestore(doc)).toList().cast<Order>();
    });
  }

  // Add a new order (from customer checkout)
  Future<void> addOrder(Order order) async {
    await _firestore.collection('orders').add(order.toFirestore());
  }

  // Update order status (for admin)
  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({'status': status});
  }

  // Get a single order by ID
  Stream<Order> getOrderById(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots().map((doc) {
      return Order.fromFirestore(doc);
    });
  }
}
