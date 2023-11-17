import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmailandPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future addUserDetails(String name, String email, String phonenumber) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'email': email,
      'phonenumber': phonenumber,
    });
  }

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}

Future<bool> updateDetails({required String displayName}) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    await user.updateDisplayName(displayName);
    debugPrint(displayName);

    return true;
  }
  return false;
}
