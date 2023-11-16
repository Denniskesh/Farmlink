import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/equipment_model.dart';

class EquipmentManager with ChangeNotifier {
  final CollectionReference _equipmentsCollection =
      FirebaseFirestore.instance.collection('equipment');
  EquipmentDetails? _equipmentDetails;

  EquipmentDetails? get equipmentDetails => _equipmentDetails;

  void setEquipmentDetails(EquipmentDetails details) {
    _equipmentDetails = details;
    notifyListeners();
  }

  Future<void> saveEquipmentData(
      EquipmentDetails equipment, String imageFilePath) async {
    try {
      // Upload image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('equipment_images/${equipment.name}.jpg');
      UploadTask uploadTask = storageReference.putFile(File(imageFilePath));
      await uploadTask.whenComplete(() {});

      // Get the image URL
      String imageUrl = await storageReference.getDownloadURL();

      await _equipmentsCollection.add({
        'mechanizationType': _equipmentDetails?.mechanizationType,
        'equipmentType': _equipmentDetails?.equipmentType,
        'name': _equipmentDetails?.name,
        'model': _equipmentDetails?.model,
        'rate': _equipmentDetails?.rate,
        'fuelType': _equipmentDetails?.fuelType,
        'consumptionRate': _equipmentDetails?.consumptionRate,
        'package': _equipmentDetails?.packageType,
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
      FirebaseFirestore.instance.collection('equipmentowners');
  QuerySnapshot one = await collectionRef1.get();
  final allData1 = one.docs.map((doc) => doc.data()).toList();
  debugPrint(allData1.toString());

  QuerySnapshot querySnapshot = await collectionRef.get();

  // Get data from docs and convert map to List
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

  return allData;
}
