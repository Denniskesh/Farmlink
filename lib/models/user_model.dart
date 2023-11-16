import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String userID;
  late String name;
  late String email;
  late String phone;

  UserModel({
    required this.userID,
    required this.name,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }
}
