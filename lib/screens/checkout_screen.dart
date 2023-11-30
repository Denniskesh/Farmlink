import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/confirmation.dart';
import 'package:farmlink/screens/in_app_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import '../models/booking_model.dart';
import '../services/booking_manager.dart';

class CheckoutScreenPage extends StatefulWidget {
  const CheckoutScreenPage({super.key, required this.e});
  final EquipmentDetails e;
  @override
  CheckOut createState() => CheckOut();
}

class CheckOut extends State<CheckoutScreenPage> {
  final BookingManager bookingManager = BookingManager();
  TextEditingController landSizeController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  TextEditingController pickupController = TextEditingController();
  TextEditingController dropoffController = TextEditingController();
  TextEditingController durationController = TextEditingController(text: '1');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void set(String value, String rate, String duration) {
    if (value.isNotEmpty) {
      var str = rate.split('per Ha');

      totalController.text =
          ((double.parse(value)) * double.parse(str[0])).toString();
      // setState(() {
      //   total.text = text;
      // });
    } else {
      totalController.text = '';
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        50;
    EquipmentDetails equipment = widget.e;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                SizedBox(
                    width: width,
                    height: height / 2,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection('equipment')
                                  .where('equipmentId',
                                      isEqualTo: equipment.equipmentId)
                                  .get(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                        child: Text('Loading ...'));
                                  } else if (snapshot.hasData &&
                                      snapshot.data!.docs.length > 0) {
                                    return Image.network(
                                      snapshot.data!.docs[0].get('imageUrl'),
                                      alignment: Alignment.center,
                                      height: double.infinity,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    );
                                  } else {
                                    return const Text('Loading ...');
                                  }
                                } else {
                                  return const Text('Loading ...');
                                }
                              })),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: width / 30, left: width / 30),
                  child: Row(
                    children: [
                      Text(
                        equipment.equipmentType,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      Text(
                        'Kes ${equipment.rate}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: width / 30, left: width / 30),
                  child: Row(
                    children: [
                      Text(
                        'Location: Juja Farm',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const Spacer(),
                      RatingBar.builder(
                        initialRating: 3,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 4,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: width / 30, right: width / 30),
                    child: Row(
                      children: [
                        Text(
                          "Package:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: width / 10,
                        ),
                        Text(equipment.packageType.toString(),
                            style: Theme.of(context).textTheme.titleSmall)
                      ],
                    )),
                SizedBox(
                  height: height / 50,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: width / 30, right: width / 30),
                    child: Row(
                      children: [
                        Text(
                          "Duration:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: width / 10,
                        ),
                        SizedBox(
                            width: width / 2,
                            child: Center(
                              child: TextFormField(
                                controller: durationController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'))
                                ],
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Duration';
                                  }
                                  return null;
                                },
                                //onChanged: (String value) {
                                //set(landSizeController.value.text,
                                //    equipment.rate, value);
                                //  },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: height / 70,
                                        horizontal: width / 30),
                                    border: const OutlineInputBorder(),
                                    //labelText: 'Duration (hours)',
                                    hintText: 'Enter Duration in hours'),
                              ),
                            ))
                      ],
                    )),
                SizedBox(
                  height: height / 50,
                ),
                Padding(
                    padding:
                        EdgeInsets.only(left: width / 30, right: width / 30),
                    child: Row(
                      children: [
                        Text(
                          "Pick-up:",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          width: width / 10,
                        ),
                        SizedBox(
                            width: width / 2,
                            child: Center(
                              child: TextFormField(
                                controller: pickupController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a location';
                                  }
                                  return null;
                                },
                                //onChanged: (String value) {
                                // set(value, equipment.rate,
                                //    durationController.value.text);
                                //  },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: height / 70,
                                        horizontal: width / 30),
                                    border: const OutlineInputBorder(),
                                    // labelText: 'Pick-up',
                                    hintText: 'Enter a location'),
                              ),
                            ))
                      ],
                    )),
                SizedBox(
                  height: height / 50,
                ),
                Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: width / 30, right: width / 30),
                        child: Row(
                          children: [
                            Text(
                              "Drop-off:",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: width / 10,
                            ),
                            SizedBox(
                                width: width / 2,
                                child: Center(
                                  child: TextFormField(
                                    controller: dropoffController,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter a location';
                                      }
                                      return null;
                                    },
                                    // onChanged: (String value) {
                                    //   set(value, equipment.rate,
                                    //      durationController.value.text);
                                    //},
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: height / 70,
                                            horizontal: width / 30),
                                        border: const OutlineInputBorder(),
                                        //labelText: 'Drop-off',
                                        hintText: 'Enter a location'),
                                  ),
                                ))
                          ],
                        ))),

                SizedBox(
                  height: height / 50,
                ),
                Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: width / 30, right: width / 30),
                        child: Row(
                          children: [
                            Text(
                              "Landsize:",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: width / 10,
                            ),
                            SizedBox(
                                width: width / 2,
                                child: Center(
                                  child: TextFormField(
                                    controller: landSizeController,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter land size';
                                      }
                                      return null;
                                    },
                                    onChanged: (String value) {
                                      set(value, equipment.rate,
                                          durationController.value.text);
                                    },
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: height / 70,
                                            horizontal: width / 30),
                                        border: const OutlineInputBorder(),
                                        //labelText: 'Landsize',
                                        hintText: 'in Ha'),
                                  ),
                                ))
                          ],
                        ))),
                SizedBox(
                  height: height * 0.02,
                ),
                Container(
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: width / 30, right: width / 30),
                        child: Row(
                          children: [
                            Text(
                              "Total:",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: width / 10,
                            ),
                            Text(
                              'Kes',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                            Container(
                              width: width / 2,
                              child: TextField(
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                                maxLines: 1,
                                readOnly: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.circular(30.0)),
                                ),
                                controller: totalController,
                              ),
                            )
                          ],
                        ))),

                SizedBox(
                  //width: width * .4,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        User? user = FirebaseAuth.instance.currentUser;
                        Booking booking = Booking(
                          userId: user!.uid,
                          equipmentId: widget.e.equipmentId!,
                          package: widget.e.packageType.toString(),
                          pickUp: pickupController.text,
                          dropOff: dropoffController.text,
                          landSize: landSizeController.text,
                          totalAmount: totalController.text,
                          equipmentType: widget.e.equipmentType,
                          duration: durationController.text,
                          rate: widget.e.rate,
                          date: DateTime.now().toString(),
                        );

                        // Save booking details to Firebase
                        await bookingManager.saveBookingDetails(booking,
                            userId: user.uid);

                        await Navigator.push(context,
                            MaterialPageRoute(builder: (_) {
                          return ConfirmationPage(
                            e: equipment,
                            price: totalController.value.text,
                          );
                        }));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 111, 95, 180),
                    ),
                    child: const Text('Complete Booking'),
                  ),
                ),

                // Text(equipment.name),
              ]),
            ),
          ),
        ),
        floatingActionButton: TextButton.icon(
          onPressed: () async {
            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InAppChatPage(
                    receiverUserEmail: widget.e.user_email.toString(),
                    receiverUserId: widget.e.userId.toString(),
                  ),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.chat_bubble_outline,
            // size: width / 10,
          ),
          label: const Text('Chat'),
          style: const ButtonStyle(),
        ),
      ),
    );
  }
}
