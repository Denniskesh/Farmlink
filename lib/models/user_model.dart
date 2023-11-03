import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  late String uid;
  late String name;
  late String email;
  late String phonenumber;
  late DateTime timestamp;

  UserModel(
      {required this.email,
      required this.uid,
      required this.name,
      required this.phonenumber,
      required this.timestamp});

  Map toMap(UserModel user) {
    var data = Map<String, dynamic>();

    data["uid"] = user.uid;
    data["name"] = user.name;
    data["email"] = user.email;
    data["phone"] = user.phonenumber;
    data["timestamp"] = user.timestamp;

    return data;
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData["uid"];
    name = mapData["username"];
    email = mapData["email"];
    phonenumber = mapData["phone"];
  }
}
