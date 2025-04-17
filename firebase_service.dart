import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _userCollection =
  FirebaseFirestore.instance.collection('user');

  Future<void> addUser(String name, String degree, String phone) async {
    await _userCollection.add({
      'name': name,
      'degree': degree,
      'phone': phone,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
