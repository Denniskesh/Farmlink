import 'package:flutter/material.dart';

class OrderExpandedPage extends StatefulWidget {
  const OrderExpandedPage({super.key, required this.order});
  final order;

  @override
  OrderExpanded createState() => OrderExpanded();
}

class OrderExpanded extends State<OrderExpandedPage> {
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
          child: Column(children: [
            SizedBox(
              height: height / 2.5,
              child: Image.network(
                order['image'],
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: height / 2.5,
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Equipment Name',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['name'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
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
                        order['Pick Up'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
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
                        order['Drop Off'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
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
                        order['Package'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width / 3,
                        child: Text(
                          'Duration',
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                      ),
                      SizedBox(
                        width: width / 7,
                      ),
                      Text(
                        order['Duration'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
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
                        order['Fee Rate'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
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
                        order['Total Fee'],
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
                        order['Land Size'],
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  ),
                  Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: width / 7,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.messenger_outline)),
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
    );
  }
}
