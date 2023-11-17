import 'dart:math';

import 'package:email_validator/email_validator.dart';
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
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    User user = widget.user;
    final TextEditingController displayName =
        TextEditingController(text: user.displayName);

    final TextEditingController email = TextEditingController(text: user.email);
    final TextEditingController phone =
        TextEditingController(text: user.phoneNumber);
    final TextEditingController maizeFarming = TextEditingController();
    final TextEditingController farmer = TextEditingController();
    final TextEditingController location = TextEditingController();
    PhoneController phoneNumber =
        PhoneController(const PhoneNumber(isoCode: IsoCode.KE, nsn: ''));

    final formKey = GlobalKey<FormState>();
    bool outlineBorder = true;
    bool mobileOnly = true;
    bool shouldFormat = true;
    bool isCountryChipPersistent = false;
    bool withLabel = true;
    bool useRtl = false;
    CountrySelectorNavigator selectorNavigator =
        const CountrySelectorNavigator.searchDelegate();

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
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Row(children: <Widget>[
                    Container(
                      child: const Icon(Icons.account_circle_rounded),
                    ),
                    Spacer(),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            user.displayName.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          Text(user.phoneNumber.toString())
                        ],
                      ),
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
                                    controller: displayName,
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
                                    controller: email,
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
                                      labelText: 'enter your email',
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
                                  child: PhoneFormField(
                                    key: phoneKey,
                                    controller: phoneNumber,
                                    shouldFormat: shouldFormat && !useRtl,
                                    // autofocus: true,
                                    autofillHints: const [
                                      AutofillHints.telephoneNumber
                                    ],
                                    countrySelectorNavigator: selectorNavigator,
                                    defaultCountry: IsoCode.KE,
                                    decoration: InputDecoration(
                                      label: withLabel
                                          ? const Text('Phone')
                                          : null,
                                      border: outlineBorder
                                          ? const OutlineInputBorder()
                                          : const UnderlineInputBorder(),
                                      hintText: withLabel ? '' : 'Phone',
                                    ),
                                    enabled: true,
                                    showFlagInInput: true,
                                    validator: _getValidator(),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    cursorColor:
                                        Theme.of(context).colorScheme.primary,

                                    onChanged: (p) {
                                      phoneNumber = PhoneController(PhoneNumber(
                                          isoCode: p!.isoCode, nsn: p.nsn));
                                      phone.text = '0${p.nsn}';
                                      print(p.nsn);
                                    },
                                    isCountryChipPersistent:
                                        isCountryChipPersistent,
                                  ),
                                )),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 15, right: 15, bottom: 0),
                                child: SizedBox(
                                  child: TextFormField(
                                    controller: location,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter location';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'location',
                                      hintText: 'enter the location',
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
                                    controller: farmer,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter farmer';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'farmer',
                                      hintText: 'enter the farmer',
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
                                    controller: maizeFarming,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'please enter maize  farming';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      labelText: 'maize  farming',
                                      hintText: 'enter the maize  farming',
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
                                          backgroundColor: Color.fromARGB(
                                              255, 203, 218, 230),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12))),
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          bool success = await updateDetails(
                                              displayName:
                                                  displayName.value.text);

                                          if (success) {
                                            user = FirebaseAuth
                                                .instance.currentUser!;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'successfully updated')));
                                          }
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
                                          bool success = await updateDetails(
                                              displayName:
                                                  displayName.value.text);

                                          if (success) {
                                            user = FirebaseAuth
                                                .instance.currentUser!;
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'successfully updated')));
                                          }
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
