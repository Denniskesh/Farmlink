import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderExpandedPage extends StatefulWidget {
  const OrderExpandedPage({super.key, required this.order});
  final order;

  @override
  OrderExpanded createState() => OrderExpanded();
}

class OrderExpanded extends State<OrderExpandedPage> {
  Future<void> deleteBooking(String orderId) async {
    try {
      await FirebaseFirestore.instance
          .collection('bookings')
          .doc(orderId)
          .delete();
      // Optional: Add any additional logic after successful deletion
    } catch (error) {
      // Handle errors during deletion
      print("Error deleting booking: $error");
      // Optional: Show a snackbar or display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
          title: Text(
        'Bookings',
        style: Theme.of(context).textTheme.titleLarge,
      )),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: [
            SizedBox(
                height: height / 2.5,
                child: FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('equipment')
                        .where('equipmentId', isEqualTo: order['equipmentId'])
                        .get(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading ...'));
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
            SizedBox(
              height: height / 70,
            ),
            SizedBox(
              height: height / 1.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width / 2.8,
                        child: Text(
                          'Equipment Name',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 9,
                      ),
                      Text(
                        order['equipmentType'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Pick Up',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['pickUp'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Drop Off',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['dropOff'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Package',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['package'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Fee Rate',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['rate'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Total Fee',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['totalAmount'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Land Size',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['landSize'].toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  SizedBox(
                    height: height / 70,
                  ),
                  Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 7,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.red, // Customize the button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () async {
                            // Call a function to delete the booking from Firestore
                            await deleteBooking(order['orderId']);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(
                                context); // Navigate back after deletion
                          },
                          child: const Text("Delete"),
                        ),
                        SizedBox(
                          width: width / 10,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.local_phone_outlined)),
                        SizedBox(
                          width: width / 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 111, 95, 180),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Ok",
                          ),
                        ),
                        // SizedBox(
                        //   width: width / 5,
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    ));
  }
}
