import 'dart:ffi';

import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/checkout_screen.dart';
import 'package:farmlink/screens/confirmation.dart';
import 'package:farmlink/screens/equipment_detail_screen2.dart';
import 'package:farmlink/screens/in_app_chat_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';

class CheckoutScreenPage extends StatefulWidget {
  const CheckoutScreenPage({super.key, required this.e});
  final EquipmentDetails e;
  @override
  CheckOut createState() => CheckOut();
}

class CheckOut extends State<CheckoutScreenPage> {
  TextEditingController landSize = TextEditingController();
  TextEditingController total = TextEditingController();
  TextEditingController duration = TextEditingController(text: '1');

  void set(String value, String rate, String duration) {
    if (value.isNotEmpty) {
      var str = rate.split('per Ha');

      total.text = ((double.parse(duration) * double.parse(value)) *
              double.parse(str[0]))
          .toString();
      // setState(() {
      //   total.text = text;
      // });
      debugPrint(total.value.text);
    } else {
      total.text = '';
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
            Container(
                child: Padding(
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
                    ))),
            // SizedBox(
            //   height: height / 25,
            // ),
            // Container(
            //     child: Padding(
            //         padding:
            //             EdgeInsets.only(left: width / 30, right: width / 30),
            //         child: Row(
            //           children: [
            //             Text(
            //               "Duration:",
            //               style: Theme.of(context).textTheme.titleLarge,
            //             ),
            //             SizedBox(
            //               width: width / 10,
            //             ),
            //             SizedBox(
            //                 width: width / 5,
            //                 child: Center(
            //                   child: TextFormField(
            //                     controller: duration,
            //                     inputFormatters: [
            //                       FilteringTextInputFormatter.allow(
            //                           RegExp('[0-9]'))
            //                     ],
            //                     validator: (value) {
            //                       if (value == null || value.isEmpty) {
            //                         return 'Please enter Duration';
            //                       }
            //                       return null;
            //                     },
            //                     onChanged: (String value) {

            //                       set(landSize.value.text, equipment.rate,
            //                           value);
            //                     },
            //                     decoration: InputDecoration(
            //                         contentPadding: EdgeInsets.symmetric(
            //                             vertical: height / 70,
            //                             horizontal: width / 30),
            //                         border: const OutlineInputBorder(),
            //                         labelText: 'Duration (hours)',
            //                         hintText: 'Enter Duration in hours'),
            //                   ),
            //                 ))
            //           ],
            //         ))),
            SizedBox(
              height: height / 25,
            ),
            Container(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: width / 30, right: width / 30),
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
                            width: width / 5,
                            child: Center(
                              child: TextFormField(
                                controller: landSize,
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
                                      duration.value.text);
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: height / 70,
                                        horizontal: width / 30),
                                    border: const OutlineInputBorder(),
                                    labelText: 'Landsize',
                                    hintText: 'Enter Land Size'),
                              ),
                            ))
                      ],
                    ))),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
                child: Padding(
                    padding:
                        EdgeInsets.only(left: width / 30, right: width / 30),
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
                            style: Theme.of(context).textTheme.displayMedium,
                            maxLines: 1,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(30.0)),
                            ),
                            controller: total,
                          ),
                        )
                      ],
                    ))),

            Positioned(
                left: 0,
                child: SizedBox(
                  width: width * .4,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (_) {
                        return ConfirmationPage(
                          e: equipment,
                          price: total.value.text,
                        );
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 111, 95, 180),
                    ),
                    child: const Text('Complete Booking'),
                  ),
                )),

            // Text(equipment.name),
          ]),
        ),
        floatingActionButton: TextButton.icon(
          onPressed: () {},
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
