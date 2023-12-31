import 'dart:convert';

List<EquipmentDetails> equipmentFromJson(String str) =>
    List<EquipmentDetails>.from(
        json.decode(str).map((x) => EquipmentDetails.fromJson(x)));

class EquipmentDetails {
  String? user_email;
  String? userId;
  String? description;
  final String? equipmentId;
  final String mechanizationType;
  final String equipmentType;
  final String name;
  final String model;
  final String rate;
  final String fuelType;
  final String consumptionRate;
  final String? packageType;
  final String imageUrl;

  EquipmentDetails({
    this.user_email,
    this.userId,
    this.equipmentId,
    required this.mechanizationType,
    required this.equipmentType,
    required this.name,
    required this.model,
    required this.rate,
    required this.fuelType,
    required this.consumptionRate,
    required this.imageUrl,
    this.packageType,
    this.description,
  });

  factory EquipmentDetails.fromJson(Map<String, dynamic> json) {
    return EquipmentDetails(
        user_email: json['user_email'],
        equipmentId: json['equipmentId'],
        userId: json['Owner_Id'],
        mechanizationType: json['mechanizationType'],
        equipmentType: json['equipmentType'],
        name: json['name'],
        model: json['model'],
        rate: json['rate'],
        fuelType: json['fuelType'],
        consumptionRate: json['consumptionRate'],
        packageType: json['package'],
        description: json['description'],
        imageUrl: json['imageURL'].toString());
  }

  @override
  String toString() {
    return """{mechanizationType:$mechanizationType,
        equipmentType:$equipmentType,
        name:$name,
        model:$model,
        rate:$rate,
        fuelType:$fuelType,
        consumptionRate:$consumptionRate,
        packageType:$packageType
    }""";
  }
}
