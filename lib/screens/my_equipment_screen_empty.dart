import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/models/owner_model.dart';
import 'package:farmlink/screens/equipment_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyEquipmentPage extends StatefulWidget {
  const MyEquipmentPage({super.key});

  @override
  MyEquipment createState() => MyEquipment();
}

class MyEquipment extends State<MyEquipmentPage> {
  List<EquipmentDetails> list = [];
  TextEditingController nearestTown = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController equipmentType = TextEditingController();
  TextEditingController filter = TextEditingController();
  TextEditingController head = TextEditingController(text: 'My Equipments');
  final _formKey = GlobalKey<FormState>();
  List<EquipmentDetails>? equipments = [];
  List<EquipmentDetails> sorted = [];
  static const List<String> choices = <String>[
    'Equipment Type',
    'Nearest Town',
    'County'
  ];

  @override
  void initState() {
    getMyequipments();
    super.initState();
  }

  filterResults(String filter, String value) async {
    List list = [];
    if (filter.isNotEmpty && value.isNotEmpty) {
      late List<EquipmentDetails> equipmentsSorted = [];
      var eq = [];

      //
      if (filter.toLowerCase() == 'equipmenttype') {
        equipmentsSorted = equipments!
            .where((equipment) => (equipment.equipmentType
                .toLowerCase()
                .contains(value.toLowerCase())))
            .toList();

        head.text = '${equipmentsSorted.length.toString()} $value found';
      } else if (filter.toLowerCase() == 'nearesttown') {
        var data = await FirebaseFirestore.instance
            .collection('equipment')
            .where('User_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());
        var data2 = await FirebaseFirestore.instance
            .collection('equipmentOwners')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());

        data.forEach((e) {
          data2.forEach((element) {
            var owner = element;
            if (owner['town']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                e['user_email'] == owner['email']) {
              eq.add(e);
            }
          });
        });

        var data3 = jsonEncode((eq));

        var result = await jsonDecode((data3));

        List<EquipmentDetails> equipment3 = result
            .map<EquipmentDetails>((json) => EquipmentDetails.fromJson(json))
            .toList();
        equipmentsSorted = equipment3;
        head.text = '${equipmentsSorted.length.toString()} found in  ${value}';
      } else if (filter.toLowerCase() == 'county') {
        var data = await FirebaseFirestore.instance
            .collection('equipment')
            .where('User_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());
        var data2 = await FirebaseFirestore.instance
            .collection('equipmentOwners')
            .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) => value.docs.map((e) => e.data()).toList());

        data.forEach((e) {
          data2.forEach((element) {
            var owner = element;
            if (owner['location']
                    .toString()
                    .toLowerCase()
                    .contains(value.toLowerCase()) &&
                e['user_email'] == owner['email']) {
              eq.add(e);
            }
          });
        });

        var data3 = jsonEncode((eq));

        var result = await jsonDecode((data3));

        List<EquipmentDetails> equipment3 = result
            .map<EquipmentDetails>((json) => EquipmentDetails.fromJson(json))
            .toList();
        equipmentsSorted = equipment3;
        head.text =
            '${equipmentsSorted.length.toString()} found in  ${value} county';
      }

      setState(() {
        list = equipmentsSorted;
      });
    } else {
      setState(() {
        list.clear();
        list.addAll(equipments!);
        head.text = 'All equipments';
      });
    }
  }

  void choiceAction(String choice) {
    if (choice.toLowerCase() == 'nearest town') {
      filter.text = 'nearestTown';
    } else if (choice.toLowerCase() == 'county') {
      filter.text = 'county';
    } else if (choice.toLowerCase() == 'equipment type') {
      filter.text = 'equipmentType';
    }
    showDialog(
        context: context,
        builder: (context) {
          double width = MediaQuery.of(context).size.width;
          double height = MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top -
              50;
          return AlertDialog(
            content: SizedBox(
                height: height / 4,
                child: Form(
                    key: _formKey,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 10, left: 15, right: 15, bottom: 5),
                            child: SizedBox(
                              width: width / 3,
                              child: TextFormField(
                                controller: nearestTown,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'please enter cow weight';
                                //   }
                                //   return null;
                                // },
                                onChanged: (value) =>
                                    {filterResults(filter.text, value)},
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: choice.toLowerCase(),
                                  hintText: '${choice.toLowerCase()} e.g Juja',
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 240, 210, 210)),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 236, 197, 197)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 202, 178, 178)),
                                  ),
                                ),
                              ),
                            )),
                        Container(
                          width: width / 6,
                          height: height * 0.073,
                          color: Colors.blue,
                          padding: const EdgeInsets.all(2.0),
                          child: IconButton(
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.search,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ))),
          );
        });
  }

  getMyequipments() async {
    User user = FirebaseAuth.instance.currentUser!;
    var data = await FirebaseFirestore.instance
        .collection('equipment')
        .where('Owner_Id', isEqualTo: user.uid)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    await jsonDecode(jsonEncode(data));
    List<EquipmentDetails> equipment = data
        .map<EquipmentDetails>((json) => EquipmentDetails.fromJson(json))
        .toList();

    setState(() {
      sorted = equipment;
      list = equipment;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        50;

    if (list.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/empty_list.png'),
              ),
              Text(
                'Do you have an idle Equipment?',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Text(
                'Tap the + button to add your equipment to our platform and hire it out to farmers near you',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    } else {
      return MaterialApp(
          home: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Equipment List',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              body: Container(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: height / 25,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: <Widget>[
                              FittedBox(
                                  fit: BoxFit.fill,
                                  child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(head.value.text,
                                          style:
                                              const TextStyle(fontSize: 70)))),
                              Align(
                                alignment: FractionalOffset.topRight,
                                child: SizedBox(
                                  width: width * 0.2,
                                  child: PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.filter_list,
                                      size: 30,
                                    ),
                                    onSelected: choiceAction,
                                    itemBuilder: (BuildContext context) {
                                      return choices.map((String choice) {
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            // ignore: deprecated_member_use
                            dataRowHeight: height / 5,

                            columns: const [
                              DataColumn(
                                label: Text(''),
                              ),
                              DataColumn(
                                label: Text(''),
                              )
                            ],
                            rows: sorted
                                .map((e) => DataRow(cells: <DataCell>[
                                      DataCell(
                                        Container(
                                            padding: EdgeInsets.only(
                                                top: height * 0.01,
                                                bottom: height * 0.01),
                                            width: width * 0.4,
                                            child: FutureBuilder(
                                                future: FirebaseFirestore
                                                    .instance
                                                    .collection('equipment')
                                                    .where('equipmentId',
                                                        isEqualTo:
                                                            e.equipmentId)
                                                    .get(),
                                                builder: (context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator();
                                                  } else if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.done) {
                                                    if (!snapshot.hasData) {
                                                      return const Center(
                                                          child: Text(
                                                              'Loading ...'));
                                                    } else if (snapshot
                                                            .hasData &&
                                                        snapshot.data!.docs
                                                                .length >
                                                            0) {
                                                      return Image.network(
                                                        snapshot.data!.docs[0]
                                                            .get('imageUrl'),
                                                        alignment:
                                                            Alignment.center,
                                                        height: double.infinity,
                                                        width: double.infinity,
                                                        fit: BoxFit.fill,
                                                      );
                                                    } else {
                                                      return const Text(
                                                          'Loading ...');
                                                    }
                                                  } else {
                                                    return const Text(
                                                        'Loading ...');
                                                  }
                                                })),
                                      ),
                                      DataCell(SizedBox(
                                          width: width * 0.45,
                                          child: Stack(children: [
                                            //align at bottom center using Align()

                                            //Alignment at Center
                                            Container(
                                                alignment: Alignment.topCenter,
                                                child: SizedBox(
                                                    height: height * 0.038,
                                                    width: width * 0.5,
                                                    child: FittedBox(
                                                        fit: BoxFit.contain,
                                                        child: Center(
                                                          child: Text(
                                                            e.equipmentType,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleLarge,
                                                          ),
                                                        )))),

                                            //alignment at veritically center, and at left horizontally
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child: SizedBox(
                                                    height: height * 0.2,
                                                    width: width * 0.40,
                                                    child: Center(
                                                        child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: SizedBox(
                                                          width: width,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right:
                                                                        width /
                                                                            5),
                                                            child: Text(
                                                              e.description
                                                                  .toString(),
                                                              // style: Theme.of(context).textTheme.displaySmall,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .displaySmall,
                                                            ),
                                                          )),
                                                    )))),

                                            Positioned(
                                              // alignment:
                                              //     FractionalOffset.bottomLeft,
                                              bottom: 0,
                                              left: 0,
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child: SizedBox(
                                                      width: width * 0.45,
                                                      height: height * 0.038,
                                                      child: Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width:
                                                                  width * .18,
                                                              child: FittedBox(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Text(
                                                                      'ksh. ${e.rate.toString()}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyLarge)),
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * .042,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(),
                                                              child: SizedBox(
                                                                width: width *
                                                                    0.18,
                                                                child:
                                                                    FittedBox(
                                                                        fit: BoxFit
                                                                            .contain,
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.only(right: width / 10),
                                                                          child: TextButton(
                                                                              onPressed: () async {
                                                                                await Navigator.push(context, MaterialPageRoute(builder: (_) => EquipmentDetailsPage(equipment: e)));
                                                                              },
                                                                              child: const Text(
                                                                                'View details',
                                                                                style: TextStyle(fontSize: 30),
                                                                              )),
                                                                        )),
                                                              ),
                                                            )
                                                          ]))),
                                            ),
                                          ])))
                                    ]))
                                .toList(),
                          ),
                        )
                      ],
                    )),
              )));
    }
  }
}
