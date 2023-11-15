import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class OwnerManager extends ChangeNotifier {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('equipmentOwners');

  Future<void> saveUserData(UserModel user, String imageFilePath) async {
    try {
      // Upload image to Firebase Storage
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user_images/${user.name}');
      UploadTask uploadTask = storageReference.putFile(File(imageFilePath));
      await uploadTask.whenComplete(() {});

      // Get the image URL
      String imageUrl = await storageReference.getDownloadURL();

      // Save user data to Firestore
      await _usersCollection.add({
        'name': user.name,
        'email': user.email,
        'phone': user.phone,
        'dob': user.dob,
        'idNumber': user.idNumber,
        'gender': user.gender,
        'location': user.location,
        'town': user.town,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      print("Error saving user data: $e");
    }
  }
}
