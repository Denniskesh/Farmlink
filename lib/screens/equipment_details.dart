import 'dart:convert';

import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/equipment_detail_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class EquipmentDetailsPage extends StatefulWidget {
  const EquipmentDetailsPage({super.key, required this.equipment});
  final EquipmentDetails equipment;

  @override
  _EquipmentDetailPageState createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        50;
    EquipmentDetails equipment = widget.equipment;

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
                  padding: EdgeInsets.all(8.0),
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
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 40),
                    ),
                  ),
                  Align(
                      alignment: FractionalOffset.topRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Text(
                          'Kes ${equipment.rate}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 25),
                        ),
                      )),
                  Align(
                      alignment: FractionalOffset.bottomRight,
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 4,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ))),
                  const Align(
                      alignment: FractionalOffset.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Location: Juja Farm',
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25),
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              child: Column(
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      'Equipment specification',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          "Model:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        width: width / 8,
                      ),
                      Text(equipment.model,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          "Fuel:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        width: width / 8,
                      ),
                      Text(equipment.fuelType,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          "Consumption:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        width: width / 8,
                      ),
                      Text(equipment.consumptionRate,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          "Equipment Type:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 25),
                        ),
                      ),
                      SizedBox(
                        width: width / 8,
                      ),
                      Text(equipment.equipmentType,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25))
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 4,
                        child: Text(
                          "Description:",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 23),
                        ),
                      ),
                      SizedBox(
                        width: width / 8,
                      ),
                      Text('',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25))
                    ],
                  ),
                  SizedBox(
                      width: width / 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          child: const Text('Hire Now'),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue)),
                        ),
                      ))
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
          label: Text('Chat'),
          style: ButtonStyle(),
        ),
      ),
    );
  }
}
