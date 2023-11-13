import 'dart:io';

class EquipmentDetails {
  final String mechanizationType;
  final String equipmentType;
  final String name;
  final String model;
  final String rate;
  final String fuelType;
  final String consumptionRate;
  final String packageType;
  final File? imageFile;

  EquipmentDetails({
    required this.mechanizationType,
    required this.equipmentType,
    required this.name,
    required this.model,
    required this.rate,
    required this.fuelType,
    required this.consumptionRate,
    this.imageFile,
    required this.packageType,
  });
}
