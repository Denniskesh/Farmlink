import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/checkout_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

import 'in_app_chat_screen.dart';

class EquipmentDetailsPage extends StatefulWidget {
  const EquipmentDetailsPage({super.key, required this.equipment});
  final EquipmentDetails equipment;

  @override
  _EquipmentDetailPageState createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailsPage> {
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        50;
    EquipmentDetails equipment = widget.equipment;
    if (height <= 303) {
      return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Equipment Details'),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                                  return CircularProgressIndicator();
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

                SizedBox(
                  height: height * 0.4,
                  child: Stack(
                    alignment: FractionalOffset.topCenter,
                    children: <Widget>[
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: Text(
                          equipment.equipmentType,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                          alignment: FractionalOffset.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Kes ${equipment.rate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )),
                      Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 4,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ))),
                      Align(
                          alignment: FractionalOffset.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Location: Juja Farm',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 8.0),
                        child: Text(
                          'Equipment specification',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Model:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          Text(equipment.model,
                              style: Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Fuel:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.fuelType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Consumption:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.consumptionRate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Equipment Type:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.equipmentType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Description:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                                width: width / 2,
                                child: Text(
                                  equipment.description.toString(),
                                  // style: Theme.of(context).textTheme.displaySmall,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )),
                          )
                        ],
                      ),
                      if (equipment.userId !=
                          FirebaseAuth.instance.currentUser!.uid)
                        FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                                width: width / 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue)),
                                    child: const Text('Hire Now'),
                                  ),
                                )))
                    ],
                  ),
                )
                // Text(equipment.name),
              ]),
            ),
            floatingActionButton: _getFAB(equipment, width)),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Equipment Details'),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
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
                                return CircularProgressIndicator();
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
                  ),
                ),

                SizedBox(
                  height: height * 0.14,
                  child: Stack(
                    alignment: FractionalOffset.topCenter,
                    children: <Widget>[
                      Align(
                        alignment: FractionalOffset.topLeft,
                        child: Text(
                          equipment.equipmentType,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Align(
                          alignment: FractionalOffset.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              'Kes ${equipment.rate}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          )),
                      Align(
                          alignment: FractionalOffset.bottomRight,
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 4,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ))),
                      Align(
                          alignment: FractionalOffset.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              'Location: Juja Farm',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 8.0),
                        child: Text(
                          'Equipment specification',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Model:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          Text(equipment.model,
                              style: Theme.of(context).textTheme.displaySmall)
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Fuel:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.fuelType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Consumption:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.consumptionRate,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Equipment Type:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(equipment.equipmentType,
                                  style:
                                      Theme.of(context).textTheme.displaySmall))
                        ],
                      ),
                      Row(
                        children: [
                          FittedBox(
                              fit: BoxFit.contain,
                              child: SizedBox(
                                width: width / 3,
                                child: Text(
                                  "Description:",
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              )),
                          SizedBox(
                            width: width / 8,
                          ),
                          FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                                width: width / 2,
                                child: Text(
                                  equipment.description.toString(),
                                  // style: Theme.of(context).textTheme.displaySmall,
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )),
                          )
                        ],
                      ),
                      if (equipment.userId !=
                          FirebaseAuth.instance.currentUser!.uid)
                        FittedBox(
                            fit: BoxFit.contain,
                            child: SizedBox(
                                width: width / 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (_) {
                                        return CheckoutScreenPage(
                                          e: equipment,
                                        );
                                      }));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue)),
                                    child: const Text('Hire Now'),
                                  ),
                                )))
                    ],
                  ),
                )
                // Text(equipment.name),
              ]),
            ),
            floatingActionButton: _getFAB(equipment, width)),
      );
    }
  }

  Widget _getFAB(EquipmentDetails equipment, double width) {
    //if (equipment.userId == FirebaseAuth.instance.currentUser!.uid) {
    //  return Container(child: const Text('Your Asset'));
    // } else {
    return TextButton.icon(
      onPressed: () async {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InAppChatPage(
                receiverUserEmail: widget.equipment.user_email.toString(),
                receiverUserId: widget.equipment.userId.toString(),
              ),
            ),
          );
        }
      },
      icon: Icon(
        Icons.chat_bubble_outline,
        size: width / 10,
      ),
      label: const Text('Chat'),
      style: const ButtonStyle(),
    );
  }
}
//}
