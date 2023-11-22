import 'package:farmlink/main.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:farmlink/screens/order_screen.dart';
import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({super.key, required this.e, required this.price});
  final EquipmentDetails e;
  final String price;

  @override
  Confirmation createState() => Confirmation();
}

class Confirmation extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    final EquipmentDetails equipment = widget.e;
    final String price = widget.price;
    double width = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Successful',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  children: [
                    SizedBox(
                      child: Text(
                        'Booking Details',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    Container(
                        height: height / 2,
                        padding: EdgeInsets.only(
                            left: width * .04, top: height * .03),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Flexible(
                            fit: FlexFit.loose,
                            child: RichText(
                              text: TextSpan(
                                  // text: '',
                                  style: Theme.of(context).textTheme.bodySmall,
                                  text:
                                      '''Your booking of the ${equipment.model}, \n${equipment.equipmentType} for Kes $price has been \nplaced successfully. \nOnly pay the Equipment \nowner/Operator after \nCompletion of Work. \nThank you for using our services. \n\nFor any queries contact us at \n+254793613719'''),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: height / 10,
                    ),
                    Container(
                      height: height / 10,
                      width: width * .42,
                      // padding: EdgeInsets.all(),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Flexible(
                            fit: FlexFit.loose,
                            child: SizedBox(
                              width: width * 0.60,
                              height: height / 12,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Farmlinkapp(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  backgroundColor: const Color.fromARGB(
                                      255, 111, 95, 180), // Background color
                                ),
                                child: const Text(
                                  'Back To Home',
                                  style: TextStyle(fontSize: 26),
                                ),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: height / 10,
                      width: width * .42,
                      // padding: EdgeInsets.all(),
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: Flexible(
                            fit: FlexFit.loose,
                            child: SizedBox(
                              width: width * 0.60,
                              height: height / 12,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return OrderPage();
                                  }));
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  backgroundColor: const Color.fromARGB(
                                      255, 236, 235, 238), // Background color
                                ),
                                child: const Text(
                                  'View Bookings',
                                  style: TextStyle(
                                      fontSize: 26, color: Colors.blue),
                                ),
                              ),
                            )),
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}
