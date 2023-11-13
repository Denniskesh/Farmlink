import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class EquipmentManager extends ChangeNotifier {
  Future uploadOwnerDetails(
    String name,
    String email,
    String phone,
    String dob,
    String idNumber,
    String location,
    String town,
    String gender,
    String imageUrl,
    String s,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('OwnerDetails').add({
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

  void addItem(item) {}

  // Add other user-related methods as needed
}
