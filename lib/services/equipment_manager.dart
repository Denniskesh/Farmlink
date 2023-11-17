import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/equipment_model.dart';

class EquipmentManager with ChangeNotifier {
  final CollectionReference _equipmentsCollection =
      FirebaseFirestore.instance.collection('equipment');
  EquipmentDetails? equipment;

  EquipmentDetails? get equipmentDetails => equipment;

  void setEquipmentDetails(EquipmentDetails details) {
    equipment = details;
    notifyListeners();
  }

  Future<void> saveEquipmentData(
      EquipmentDetails equipment, String imageFilePath) async {
    try {
      // Upload image to Firebase Storage
      Reference storageReference1 = FirebaseStorage.instance
          .ref()
          .child('equipment_images/${equipment.name}.jpg');
      UploadTask uploadTask = storageReference1.putFile(File(imageFilePath));
      await uploadTask.whenComplete(() {});

      // Get the image URL
      String imageUrl = await storageReference1.getDownloadURL();

      await _equipmentsCollection.add({
        'mechanizationType': equipment.mechanizationType,
        'equipmentType': equipment.equipmentType,
        'name': equipment.name,
        'model': equipment.model,
        'rate': equipment.rate,
        'fuelType': equipment.fuelType,
        'consumptionRate': equipment.consumptionRate,
        'package': equipment.packageType,
        'imageUrl':
            imageUrl, // You need to upload the image to storage and store the URL
      });
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  void addItem(item) {}
}

Future<List> getEquipments() async {
  CollectionReference collectionRef =
      FirebaseFirestore.instance.collection('equipment');
  CollectionReference collectionRef1 =
      FirebaseFirestore.instance.collection('equipmentowner');
  QuerySnapshot one = await collectionRef1.get();
  final allData1 = one.docs.map((doc) => doc.data()).toList();

  QuerySnapshot querySnapshot = await collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
  debugPrint(allData.toString());

  return allData;
}
