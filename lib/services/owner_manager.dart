import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class OwnerManager extends ChangeNotifier {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('EquipmentOwners');

  Future<void> uploadUserDetails(
    String name,
    String email,
    String phone,
    String dob,
    String idNumber,
    String location,
    String town,
    String gender,
    String imageUrl,
  ) async {
    try {
      await _usersCollection.add({
        'name': name,
        'email': email,
        'phone': phone,
        'dob': dob,
        'idNumber': idNumber,
        'location': location,
        'town': town,
        'gender': gender,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      throw Exception('Failed to upload user details: $e');
    }
  }

  // Add other user-related methods as needed
}
