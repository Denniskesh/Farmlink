import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:farmlink/screens/profile_screen.dart';
import 'package:farmlink/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phone_form_field/phone_form_field.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user});
  final User user;

  @override
  EditProfile createState() => EditProfile();
}

class EditProfile extends State<EditProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late User _user;
  final TextEditingController _nameController = TextEditingController();
  //PhoneController phoneNumber =
  //   PhoneController(const PhoneNumber(isoCode: IsoCode.KE, nsn: ''));
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _farmingTypeController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    _user = _auth.currentUser!;
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(_user.uid).get();

    if (userDoc.exists) {
      setState(() {
        _nameController.text = userDoc['name'] ?? '';
        _emailController.text = _user.email!;
        _categoryController.text = userDoc['category'] ?? '';
        _farmingTypeController.text = userDoc['farmingType'] ?? '';
        _locationController.text = userDoc['location'] ?? '';
        _phoneController = userDoc['phonenumber'] ?? '';
      });
    }
  }

  Future<void> _updateUserProfile() async {
    try {
      await _firestore.collection('users').doc(_user.uid).update({
        'name': _nameController.text,
        'phonenumber': _phoneController,
        'email': _emailController.text,
        'location': _locationController.text,
        'category': _categoryController.text,
        'farmingType': _farmingTypeController.text,
      });

      print("User profile updated successfully!");
    } catch (e) {
      print("Error updating user profile: $e");
    }
  }

  void _cancelChanges() {
    // Reset controllers to the original values
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    //User user = widget.user;
    //final TextEditingController displayName =
    //  TextEditingController(text: user.displayName);

    //final TextEditingController email = TextEditingController(text: user.email);
    //final TextEditingController phone =
    //    TextEditingController(text: user.phoneNumber);
    //final TextEditingController maizeFarming = TextEditingController();
    //final TextEditingController farmer = TextEditingController();
    //final TextEditingController location = TextEditingController();
    // PhoneController phoneNumber =
    // PhoneController(const PhoneNumber(isoCode: IsoCode.KE, nsn: ''));

    final formKey = GlobalKey<FormState>();
    bool outlineBorder = true;
    bool mobileOnly = true;
    bool shouldFormat = true;
    bool isCountryChipPersistent = false;
    bool withLabel = true;
    bool useRtl = false;
    //CountrySelectorNavigator selectorNavigator =
    //  const CountrySelectorNavigator.searchDelegate();

    final phoneKey = GlobalKey<FormFieldState<PhoneNumber>>();

    PhoneNumberInputValidator? _getValidator() {
      List<PhoneNumberInputValidator> validators = [];
      if (mobileOnly) {
        validators.add(PhoneValidator.validMobile());
      }
      return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Edit Profile',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(children: <Widget>[
                SizedBox(
                    child: Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: const Row(children: <Widget>[
                    Icon(Icons.account_circle_rounded),
                    Spacer(),
                    Column(
                      children: <Widget>[
                        //Text(
                        // user.displayName.toString(),
                        //  style: Theme.of(context).textTheme.displayMedium,
                        //),
                        //Text(user.phoneNumber.toString())
                      ],
                    )
                  ]),
                )),
                Center(
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter Your Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Name',
                                      hintText: 'enter the full Name',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _emailController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter the email';
                                      }
                                      var a = validateEmail(value);
                                      if (a != 'valid') {
                                        return a;
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      labelText: 'Email',
                                      hintText: 'enter email',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _phoneController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter phone number';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Phone Number',
                                      hintText: 'eg. 254765432333',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _locationController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter nearest town';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'location',
                                      hintText: 'Nearest town',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _categoryController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter category';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Category',
                                      hintText: 'eg. Farmer/ Equipment Owner',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: _farmingTypeController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter farming type';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'Farming Type',
                                      hintText: 'eg maize farming',
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 236, 197, 197)),
                                      ),
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 202, 178, 178)),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                                width: double.infinity,
                                height: 60,
                                padding: const EdgeInsets.only(
                                    right: 16.0, left: 16.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              255, 203, 218, 230),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          _cancelChanges;
                                          //bool success = await updateDetails(
                                          //  displayName:
                                          // displayName.value.text);

                                          // if (success) {
                                          //  _user = FirebaseAuth
                                          //  .instance.currentUser!;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profile(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'successfully updated')));
                                        }
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.0))),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          _updateUserProfile;
                                          //bool success = await updateDetails(
                                          // displayName:
                                          //   displayName.value.text);

                                          //if (success) {
                                          // user = FirebaseAuth
                                          //   .instance.currentUser!;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const Profile(),
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'successfully updated')));
                                        }
                                      },
                                      child: const Text(
                                        "Update",
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )))
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

validateEmail(String value) {
  assert(EmailValidator.validate(value));
}
