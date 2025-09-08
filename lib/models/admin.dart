
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

class Admin {
  final String id;
  final String email;
  // Note: password_hash will not be stored directly in the client-side model
  // It's handled by Firebase Authentication.

  Admin({
    required this.id,
    required this.email,
  });

  factory Admin.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Admin(
      id: doc.id,
      email: data['email'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
    };
  }
}
