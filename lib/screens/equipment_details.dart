import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/checkout_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  Future<String> downloadfromfirebase(String url) async {
    // create reference

    Reference ref = FirebaseStorage.instance.ref().child(url);
    String _myurl = await ref.getDownloadURL();
    return _myurl.toString();
  }
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
                        child: Image.network(
                      //equipment.imageFile
                      downloadfromfirebase(equipment.imageUrl) as String,
                      alignment: Alignment.center,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )),
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
                              child: Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    equipment.description.toString(),
                                    // style: Theme.of(context).textTheme.displaySmall,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )),
                            ))
                      ],
                    ),
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
                                        MaterialStateProperty.all(Colors.blue)),
                                child: const Text('Hire Now'),
                              ),
                            )))
                  ],
                ),
              )
              // Text(equipment.name),
            ]),
          ),
          floatingActionButton: TextButton.icon(
            onPressed: () {},
            icon: Icon(
              Icons.chat_bubble_outline,
              size: width / 10,
            ),
            label: const Text('Chat'),
            style: const ButtonStyle(),
          ),
        ),
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
                        child: Image.network(
                      //equipment.imageFile
                      'https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      fit: BoxFit.fill,
                    )),
                  )),

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
                              child: Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    equipment.description.toString(),
                                    // style: Theme.of(context).textTheme.displaySmall,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  )),
                            ))
                      ],
                    ),
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
                                        MaterialStateProperty.all(Colors.blue)),
                                child: const Text('Hire Now'),
                              ),
                            )))
                  ],
                ),
              )
              // Text(equipment.name),
            ]),
          ),
          floatingActionButton: TextButton.icon(
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
          ),
        ),
      );
    }
  }
}
