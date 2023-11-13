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
// [
//     {
//       "description":"Lady with a red umbrella",
//       "image-url":"https://i.imgur.com/pwpWaWu.jpg"
//     },
//     {
//       "description":"Flowers and some fruits",
//       "image-url":"https://i.imgur.com/KIPtISY.jpg"
//     },
//     {
//       "description":"Beautiful scenery",
//       "image-url":"https://i.imgur.com/2jMCqQ2.jpg"
//     },
//     {
//       "description":"Some kind of bird",
//       "image-url":"https://i.imgur.com/QFDRuAh.jpg"
//     },
//     {
//       "description":"The attack of dragons",
//       "image-url":"https://i.imgur.com/8yIIokW.jpg"
//     }
    
//   ]