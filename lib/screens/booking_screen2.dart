// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingsPage2 extends StatefulWidget {
  const BookingsPage2({super.key});

  @override
  State<BookingsPage2> createState() => _BookingsPage2State();
}

class _BookingsPage2State extends State<BookingsPage2> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _formKey1 = GlobalKey<FormState>();
    late GoogleMapController googleMapController;

    final TextEditingController equipmentType = TextEditingController();
    final TextEditingController countyLocation = TextEditingController();
    final TextEditingController nearestTown = TextEditingController();
    final TextEditingController durationDate = TextEditingController();
    final TextEditingController pickUpTime = TextEditingController();
    final TextEditingController package = TextEditingController();

    const CameraPosition _initialCameraPosition =
        CameraPosition(target: LatLng(20.5937, 78.9629));
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Center(
                  child: Text(
                'Request Equipment',
                style: TextStyle(color: Colors.black),
              )),
              actions: [
                IconButton(
                  onPressed: () {
                    // Navigator.of(context)
                    //   .push(MaterialPageRoute(builder: (context) {
                    //  return const EquipmentListPage();
                    //}));
                  },
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            body:
                // height: double.maxFinite,

                //alignment:new Alignment(x, y)

                Stack(children: [
              Positioned(
                child: GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  onMapCreated: (GoogleMapController c) {
                    // to control the camera position of the map
                    var googleMapController = c;
                  },
                ),
              ),
              Positioned(
                child: Align(
                    alignment: FractionalOffset.topCenter,
                    child: Container(
                        child: SingleChildScrollView(
                            child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 0),
                                    child: TextFormField(
                                      controller: equipmentType,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter the type of equipment';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Equipment Type',
                                        hintText: 'Enter Equipment Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 0),
                                    child: TextFormField(
                                      controller: countyLocation,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter the county location';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'County Location',
                                        hintText: 'Set County Location',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 16),
                                    child: TextFormField(
                                      controller: nearestTown,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter nearest town';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Nearest Town',
                                        hintText: 'Set Nearest Town',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )))),
              ),
              Positioned(
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: Container(
                        child: SingleChildScrollView(
                            child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Form(
                              key: _formKey1,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 0),
                                    child: TextFormField(
                                      controller: durationDate,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter the type of equipment';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Duration Date',
                                        hintText: 'Select Date',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 0),
                                    child: TextFormField(
                                      controller: pickUpTime,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter the county location';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Pick Up Time',
                                        hintText: '00:00',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 0),
                                    child: TextFormField(
                                      controller: package,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'please enter nearest town';
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Package',
                                        hintText: 'With Operator',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 236, 197, 197)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 202, 178, 178)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 70,
                                    padding: const EdgeInsets.only(
                                        top: 10,
                                        left: 15,
                                        right: 15,
                                        bottom: 8),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        if (_formKey1.currentState!
                                            .validate()) {}
                                      },
                                      child: const Text(
                                        "Continue",
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )))),
              )
            ])));
  }
}
