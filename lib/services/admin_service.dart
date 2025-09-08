
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;

class AdminService {
  final _adminsCollection = FirebaseFirestore.instance.collection('admins');

  Future<bool> isAdmin(String uid) async {
    final doc = await _adminsCollection.doc(uid).get();
    return doc.exists;
  }
}
