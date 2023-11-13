import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/equipment_model.dart';

class EquipmentManager with ChangeNotifier {
  EquipmentDetails? _equipmentDetails;

  EquipmentDetails? get equipmentDetails => _equipmentDetails;

  void setEquipmentDetails(EquipmentDetails details) {
    _equipmentDetails = details;
    notifyListeners();
  }

  Future<void> saveToFirestore() async {
    // Implement Firestore saving logic here
    // Use Firebase or any other Firestore SDK
    // Example using Firebase:
    await FirebaseFirestore.instance.collection('equipment').add({
      'mechanizationType': _equipmentDetails?.mechanizationType,
      'equipmentType': _equipmentDetails?.equipmentType,
      'name': _equipmentDetails?.name,
      'model': _equipmentDetails?.model,
      'rate': _equipmentDetails?.rate,
      'fuelType': _equipmentDetails?.fuelType,
      'consumptionRate': _equipmentDetails?.consumptionRate,
      'package': _equipmentDetails?.packageType,
      'imageURL': _equipmentDetails
          ?.imageFile, // You need to upload the image to storage and store the URL
    });
  }

  void addItem(item) {}
}
