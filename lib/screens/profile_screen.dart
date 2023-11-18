// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:email_validator/email_validator.dart';
import 'package:farmlink/screens/edit_profile.dart';
import 'package:farmlink/services/auth/auth_service.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  ProfilePage createState() => ProfilePage();
}

class ProfilePage extends State<Profile> {
  //final User? user = FirebaseAuth.instance.currentUser;
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User user;
  String name = '';
  String phone = '';

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    user = _auth.currentUser!;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    if (userDoc.exists) {
      setState(() {
        name = userDoc['name'];
        phone = userDoc['phonenumber'];
      });
      return user;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: width / 6,
                      child: const FittedBox(
                        fit: BoxFit.contain,
                        child: Flexible(
                            child: Padding(
                          padding: EdgeInsets.only(
                              // left: width / 70,
                              ),
                          child: Icon(
                            Icons.account_circle_rounded,
                            color: Colors.grey,
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      width: width / 1.7,
                      height: height / 12,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Flexible(
                          fit: FlexFit.loose,
                          child: Column(children: [
                            Text(
                              ' $name',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                            Text(
                              ' $phone',
                              style: Theme.of(context).textTheme.displaySmall,
                            )
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width / 6,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: Flexible(
                            child: Padding(
                                padding: EdgeInsets.only(),
                                child: IconButton(
                                  onPressed: () async {
                                    await Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return EditProfilePage(
                                        user: user!,
                                      );
                                    }));
                                  },
                                  icon: const Icon(
                                    IconData(0xe21a,
                                        fontFamily: 'MaterialIcons'),
                                    color: Colors.grey,
                                  ),
                                )),
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height / 15,
              ),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'Notifications',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'Chats',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'Payments',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'My Equipments',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'Setting',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 20,
                padding: EdgeInsets.only(right: width / 20, left: width / 20),
                child: Row(
                  children: [
                    Text(
                      'Support',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.navigate_next))
                  ],
                ),
              ),
              const Divider(),
              Container(
                height: height / 10,
                // padding: EdgeInsets.all(),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Flexible(
                      fit: FlexFit.loose,
                      child: SizedBox(
                        width: width * 0.50,
                        child: ElevatedButton(
                          onPressed: () async {
                            final authService = Provider.of<AuthService>(
                                context,
                                listen: false);
                            authService.signOut();
                          },
                          child: Text('Sign Out'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(
                                255, 111, 95, 180), // Background color
                          ),
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
