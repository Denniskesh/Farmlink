import 'dart:convert';

import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/equipment_detail_screen.dart';
import 'package:farmlink/screens/equipment_details.dart';
import 'package:farmlink/services/equipment_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EquipmentListPage extends StatefulWidget {
  const EquipmentListPage({super.key});

  @override
  _EquipmentListPage createState() => _EquipmentListPage();
}

class _EquipmentListPage extends State<EquipmentListPage> {
  TextEditingController nearestTown = TextEditingController();
  TextEditingController county = TextEditingController();
  TextEditingController equipmentType = TextEditingController();
  TextEditingController filter = TextEditingController();
  TextEditingController head = TextEditingController(text: 'All Equipments');
  final _formKey = GlobalKey<FormState>();
  List<EquipmentDetails>? equipments = [];
  List<EquipmentDetails> sortedEquipments = [];
  static const List<String> choices = <String>[
    'Equipment Type',
    'Nearest Town',
    'County'
  ];

  // late var equipment = jsonDecode(equipments) as List;

  // late List<EquipmentDetails> s =
  //     equipment.map((e) => EquipmentDetails.fromJson(e)).toList();
  @override
  void initState() {
    super.initState();
    equipment();
  }

  equipment() async {
    List equipmentsdata = await getEquipments();

    var data2 = jsonEncode((equipmentsdata));

    var result = await jsonDecode((data2));

    List<EquipmentDetails> equipment1 = result
        .map<EquipmentDetails>((json) => EquipmentDetails.fromJson(json))
        .toList();

    setState(() {
      equipments = equipment1;
      sortedEquipments = equipment1;
    });

    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  filterResults(String filter, String value) async {
    debugPrint(equipments.toString());
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    if (filter.isNotEmpty && value.isNotEmpty) {
      late List<EquipmentDetails> equipmentsSorted = [];
      equipmentsSorted = equipments!
          .where((equipment) => (equipment.equipmentType
              .toLowerCase()
              .contains(value.toLowerCase())))
          .toList();

      head.text = '${equipmentsSorted.length.toString()} $value found';

      setState(() {
        sortedEquipments = equipmentsSorted;
      });
    } else {
      setState(() {
        sortedEquipments.clear();
        sortedEquipments.addAll(equipments!);
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
                            icon: Icon(
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top -
        50;
    if (equipments!.isEmpty) {
      equipment();
      debugPrint(equipments.toString());

      return Dialog(
        child: SizedBox(
            height: height / 5,
            child: const Center(
              child: Stack(
                alignment: FractionalOffset.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Loading"),
                ],
              ),
            )),
      );
    }

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
                                child: Flexible(
                                    fit: FlexFit.loose,
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(head.value.text,
                                            style: TextStyle(fontSize: 70))))),
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
                          dataRowHeight: height / 4,

                          columns: const [
                            DataColumn(
                              label: Text(''),
                            ),
                            DataColumn(
                              label: Text(''),
                            )
                          ],
                          rows: sortedEquipments
                              .map((e) => DataRow(cells: <DataCell>[
                                    DataCell(SizedBox(
                                        width: width * 0.4,
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                                          fit: BoxFit.fill,
                                        ))),
                                    DataCell(SizedBox(
                                        width: width * 0.45,
                                        child: Stack(children: [
                                          //align at bottom center using Align()

                                          //Alignment at Center
                                          Container(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                  height: height * 0.038,
                                                  width: width * 0.5,
                                                  child: FittedBox(
                                                      fit: BoxFit.contain,
                                                      child: Flexible(
                                                          fit: FlexFit.loose,
                                                          child: Center(
                                                            child: Text(
                                                              e.equipmentType,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleLarge,
                                                            ),
                                                          ))))),

                                          //alignment at veritically center, and at left horizontally
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Container(
                                                  height: height * 0.2,
                                                  width: width * 0.5,
                                                  child: Center(
                                                      child: FittedBox(
                                                          fit: BoxFit.contain,
                                                          child: Container(
                                                            width: width / 2,
                                                            child: Flexible(
                                                                fit: FlexFit
                                                                    .loose,
                                                                child: Text(
                                                                  'widget empowers developers to create adaptive and user-friendly interfaces, enabling a smooth and consistent user experience across devices',
                                                                  // style: Theme.of(context).textTheme.displaySmall,
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .displaySmall,
                                                                )),
                                                          ))))),

                                          Positioned(
                                            // alignment:
                                            //     FractionalOffset.bottomLeft,
                                            bottom: 0,
                                            left: 0,
                                            child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Flexible(
                                                  fit: FlexFit.tight,
                                                  child: SizedBox(
                                                      width: width * 0.45,
                                                      height: height * 0.038,
                                                      child: Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                                width:
                                                                    width * .18,
                                                                child:
                                                                    FittedBox(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  child: Flexible(
                                                                      fit: FlexFit
                                                                          .loose,
                                                                      child: Text(
                                                                          'ksh. ${e.rate}',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyLarge)),
                                                                )),
                                                            SizedBox(
                                                              width:
                                                                  width * .042,
                                                            ),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .only(),
                                                                child:
                                                                    Container(
                                                                  width: width *
                                                                      0.18,
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    child:
                                                                        Flexible(
                                                                      fit: FlexFit
                                                                          .loose,
                                                                      child: TextButton(
                                                                          onPressed: () async {
                                                                            await Navigator.push(context,
                                                                                MaterialPageRoute(builder: (_) => EquipmentDetailsPage(equipment: e)));
                                                                          },
                                                                          child: Text(
                                                                            'View details',
                                                                            style:
                                                                                TextStyle(fontSize: 30),
                                                                          )),
                                                                    ),
                                                                  ),
                                                                ))
                                                          ]))),
                                            ),
                                          )
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
