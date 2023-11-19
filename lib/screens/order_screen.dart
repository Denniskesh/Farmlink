import 'package:farmlink/screens/add_equipment_detail_screen.dart';
import 'package:farmlink/screens/order_expanded.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  @override
  Order createState() => Order();
}

class Order extends State<OrderPage> {
  List<Map<String, dynamic>> list1 = [
    {
      "time": "2023-06-16T10:31:12.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message": "A1 Brahmslaan 3862TD Nijkerk 73278"
    },
    {
      "time": "2020-06-16T10:29:35.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message": "A2 NS Station Rheden Dr. Langemijerweg 6991EV Rheden 73286"
    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message": "A2 VWS Utrechtseweg 6871DR Renkum 74636"
    },
    {
      "time": "2020-06-14T09:40:58.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message":
          "B2 5623EJ : Michelangelolaan Eindhoven Obj: ziekenhuizen 8610 Ca CATH route 522 PAAZ Rit: 66570"
    },
    {
      "time": "2020-06-15T09:41:18.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message": "A2 VWS Utrechtseweg 6871DR Renkum 74636"
    },
    {
      "time": "2023-06-16T10:31:12.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
    {
      "time": "2023-11-19T10:31:12.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
    {
      "time": "2023-11-18T10:31:12.000Z",
      "name": "Tractor 1",
      "Pick Up": "Juja",
      "Drop Off": "Juja",
      "Duration": "1 day",
      "Package": "With Operator",
      "Fee Rate": "2000 per Ha",
      "Total Fee": "8000",
      "Land Size": "4",
      "image":
          "https://images.unsplash.com/photo-1614977645540-7abd88ba8e56?q=80&w=1973&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "message":
          "P2 BGM-01 HV buiten materieel (Gas lekkage) Franckstraat Arnhem 073631"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final sorted = list1.map((e) => (e)).toList()
      ..sort((a, b) => b['time'].compareTo(a['time']));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: sorted.length,
            itemBuilder: (_, index) {
              bool isSameDate = true;
              final String dateString = sorted.elementAt(index)['time'];
              final DateTime date = DateTime.parse(dateString);
              final item = sorted.elementAt(index);
              final String name = sorted.elementAt(index)['name'];
              final String dropOff = sorted.elementAt(index)['Drop Off'];
              final String pickUp = sorted.elementAt(index)['Pick Up'];
              final String image = sorted.elementAt(index)['image'];
              if (index == 0) {
                isSameDate = false;
              } else {
                final String prevDateString =
                    sorted.elementAt(index - 1)['time'];
                final DateTime prevDate = DateTime.parse(prevDateString);
                isSameDate = date.isSameDate(prevDate);
              }
              if (index == 0 || !(isSameDate)) {
                if (date.formatDate() == DateTime.now().formatDate()) {
                  return Column(children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    // Text('Today'),
                    ListTile(title: Text('Today')),
                    SizedBox(
                        height: height * .1,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OrderExpandedPage(
                                  order: sorted.elementAt(index));
                            }));
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * .3,
                                child: Image.network(
                                  image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                width: width * .6,
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Text(
                                        name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.watch_later_outlined),
                                      Text(
                                        DateFormat('E, d MMM yyy h:mm a')
                                            .format(date),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Pick Up   ${pickUp}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Pick Up   ${dropOff}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium)
                                    ],
                                  )
                                ]),
                              )
                            ],
                          ),
                        )),
                    Divider(),
                  ]);
                } else if (date.formatDate() ==
                    DateTime.now()
                        .subtract(const Duration(days: 1))
                        .formatDate()) {
                  return Column(children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    // Text('Yesterday'),
                    ListTile(title: Text('Yesterday')),
                    SizedBox(
                      height: height * .1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return OrderExpandedPage(
                                order: sorted.elementAt(index));
                          }));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * .3,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: width * .6,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.watch_later_outlined),
                                    Text(
                                      DateFormat('E, d MMM yyy h:mm a')
                                          .format(date),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Pick Up   ${pickUp}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Pick Up   ${dropOff}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)
                                  ],
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                  ]);
                } else {
                  return Column(children: [
                    SizedBox(
                      height: height * .05,
                    ),
                    // Text(date.formatDate()),
                    ListTile(title: Text(date.formatDate())),
                    SizedBox(
                        height: height * .1,
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return OrderExpandedPage(
                                    order: sorted.elementAt(index));
                              }));
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (_) {
                                  return OrderExpandedPage(
                                      order: sorted.elementAt(index));
                                }));
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * .3,
                                    child: Image.network(
                                      image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Spacer(),
                                  SizedBox(
                                    width: width * .6,
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          Text(
                                            name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge,
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.watch_later_outlined),
                                          Text(
                                            DateFormat('E, d MMM yyy h:mm a')
                                                .format(date),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Pick Up   ${pickUp}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('Pick Up   ${dropOff}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                        ],
                                      )
                                    ]),
                                  )
                                ],
                              ),
                            ))),
                    Divider(),
                  ]);
                }
              } else {
                // return ListTile(title: Text('item $index'));
                return Column(children: [
                  SizedBox(
                    height: height * .05,
                  ),
                  // ListTile(title: Text('item $index')),
                  SizedBox(
                      height: height * .1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return OrderExpandedPage(
                                order: sorted.elementAt(index));
                          }));
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * .3,
                              child: Image.network(
                                image,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Spacer(),
                            SizedBox(
                              width: width * .6,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Text(
                                      name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.watch_later_outlined),
                                    Text(
                                      DateFormat('E, d MMM yyy h:mm a')
                                          .format(date),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Pick Up   ${pickUp}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text('Pick Up   ${dropOff}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)
                                  ],
                                )
                              ]),
                            )
                          ],
                        ),
                      )),
                  Divider(),
                ]);
              }
            }),
      ),
    );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }

  int getDifferenceInDaysWithNow() {
    final now = DateTime.now();
    return now.difference(this).inDays;
  }
}

class Mylist {
  String time;
  int message;

  Mylist(this.time, this.message);

  @override
  String toString() {
    return '{ ${this.time}, ${this.message} }';
  }
}
