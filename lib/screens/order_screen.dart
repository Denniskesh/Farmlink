import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/screens/order_expanded.dart';
import 'package:farmlink/services/booking_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  Order createState() => Order();
}

class Order extends State<OrderPage> {
  List list1 = [];

  @override
  void initState() {
    getOrder();

    super.initState();
  }

  void getOrder() async {
    var list2 = await getOrders();

    var list4 = await jsonDecode(jsonEncode(list2));

    setState(() {
      list1 = list4;
    });
    Future.delayed(const Duration(seconds: 1)).then((value) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sorted = list1.map((e) => (e)).toList()
      ..sort((a, b) => b['date'].compareTo(a['date']));

    final appBar = AppBar(
      title: const Text('Bookings'),
    );
    double width = MediaQuery.of(context).size.width;
    double height =
        MediaQuery.of(context).size.height - appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: list1.isEmpty
          ? Center(
              child: Text('You have no orders yet'),
            )
          : Container(
              padding: EdgeInsets.only(left: width / 50),
              child: ListView.builder(
                  itemCount: sorted.length,
                  itemBuilder: (_, index) {
                    bool isSameDate = true;
                    final String dateString = sorted.elementAt(index)['date'];
                    final DateTime date = DateTime.parse(dateString);

                    final String name =
                        sorted.elementAt(index)['equipmentType'];
                    final String equipmentId =
                        sorted.elementAt(index)['equipmentId'];
                    final String dropOff = sorted.elementAt(index)['dropOff'];
                    final String pickUp = sorted.elementAt(index)['pickUp'];

                    if (index == 0) {
                      isSameDate = false;
                    } else {
                      final String prevDateString =
                          sorted.elementAt(index - 1)['date'];
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
                            height: height * .15,
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
                                      child: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection('equipment')
                                              .where('equipmentId',
                                                  isEqualTo:
                                                      equipmentId.toString())
                                              .get(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child: Text('Loading ...'));
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.docs.length >
                                                      0) {
                                                return Image.network(
                                                  snapshot.data!.docs[0]
                                                      .get('imageUrl')
                                                      .toString(),
                                                  alignment: Alignment.center,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                );
                                              } else {
                                                return const Text(
                                                    'Loading ...');
                                              }
                                            } else {
                                              return const Text('Loading ...');
                                            }
                                          })),
                                  Spacer(),
                                  FittedBox(
                                    child: SizedBox(
                                      width: width * .6,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: FittedBox(
                                                child: Text(
                                                  name.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          child: FittedBox(
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.contain,
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    size: width * .05,
                                                  ),
                                                  SizedBox(
                                                    width: width * .7,
                                                    height: height * .023,
                                                    child: FittedBox(
                                                      alignment:
                                                          FractionalOffset
                                                              .centerLeft,
                                                      child: Text(
                                                        DateFormat(
                                                                'E, d MMM yyy h:mm a                ')
                                                            .format(date),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Text(
                                                  'Pick Up   ${pickUp.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                  'Drop Off   ${dropOff.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            ))
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                            height: height * .15,
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
                                      child: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection('equipment')
                                              .where('equipmentId',
                                                  isEqualTo:
                                                      equipmentId.toString())
                                              .get(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child: Text('Loading ...'));
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.docs.length >
                                                      0) {
                                                return Image.network(
                                                  snapshot.data!.docs[0]
                                                      .get('imageUrl')
                                                      .toString(),
                                                  alignment: Alignment.center,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                );
                                              } else {
                                                return const Text(
                                                    'Loading ...');
                                              }
                                            } else {
                                              return const Text('Loading ...');
                                            }
                                          })),
                                  Spacer(),
                                  FittedBox(
                                    child: SizedBox(
                                      width: width * .6,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: FittedBox(
                                                child: Text(
                                                  name.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          child: FittedBox(
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.contain,
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    size: width * .05,
                                                  ),
                                                  SizedBox(
                                                    width: width * .7,
                                                    height: height * .023,
                                                    child: FittedBox(
                                                      alignment:
                                                          FractionalOffset
                                                              .centerLeft,
                                                      child: Text(
                                                        DateFormat(
                                                                'E, d MMM yyy h:mm a                ')
                                                            .format(date),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Text(
                                                  'Pick Up   ${pickUp.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                  'Drop Off   ${dropOff.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            ))
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
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
                            height: height * .15,
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
                                      child: FutureBuilder(
                                          future: FirebaseFirestore.instance
                                              .collection('equipment')
                                              .where('equipmentId',
                                                  isEqualTo:
                                                      equipmentId.toString())
                                              .get(),
                                          builder: (context,
                                              AsyncSnapshot snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return CircularProgressIndicator();
                                            } else if (snapshot
                                                    .connectionState ==
                                                ConnectionState.done) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                    child: Text('Loading ...'));
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.docs.length >
                                                      0) {
                                                return Image.network(
                                                  snapshot.data!.docs[0]
                                                      .get('imageUrl')
                                                      .toString(),
                                                  alignment: Alignment.center,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  fit: BoxFit.fill,
                                                );
                                              } else {
                                                return const Text(
                                                    'Loading ...');
                                              }
                                            } else {
                                              return const Text('Loading ...');
                                            }
                                          })),
                                  Spacer(),
                                  FittedBox(
                                    child: SizedBox(
                                      width: width * .6,
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              child: FittedBox(
                                                child: Text(
                                                  name.toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleLarge,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          child: FittedBox(
                                            alignment: Alignment.topLeft,
                                            fit: BoxFit.contain,
                                            child: Column(children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.watch_later_outlined,
                                                    size: width * .05,
                                                  ),
                                                  SizedBox(
                                                    width: width * .7,
                                                    height: height * .023,
                                                    child: FittedBox(
                                                      alignment:
                                                          FractionalOffset
                                                              .centerLeft,
                                                      child: Text(
                                                        DateFormat(
                                                                'E, d MMM yyy h:mm a                ')
                                                            .format(date),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ]),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 0),
                                              child: Text(
                                                  'Pick Up   ${pickUp.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                                child: FittedBox(
                                              fit: BoxFit.contain,
                                              child: Text(
                                                  'Drop Off   ${dropOff.toString()}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium),
                                            ))
                                          ],
                                        )
                                      ]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                        ]);
                      }
                    } else {
                      // return ListTile(title: Text('item $index'));

                      return Column(children: [
                        SizedBox(
                          height: height * .02,
                        ),
                        // ListTile(title: Text('item $index')),
                        SizedBox(
                          height: height * .15,
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
                                    child: FutureBuilder(
                                        future: FirebaseFirestore.instance
                                            .collection('equipment')
                                            .where('equipmentId',
                                                isEqualTo:
                                                    equipmentId.toString())
                                            .get(),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return CircularProgressIndicator();
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                  child: Text('Loading ...'));
                                            } else if (snapshot.hasData &&
                                                snapshot.data!.docs.length >
                                                    0) {
                                              return Image.network(
                                                snapshot.data!.docs[0]
                                                    .get('imageUrl')
                                                    .toString(),
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
                                Spacer(),
                                FittedBox(
                                  child: SizedBox(
                                    width: width * .6,
                                    child: Column(children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            child: FittedBox(
                                              child: Text(
                                                name.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleLarge,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        child: FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.contain,
                                          child: Column(children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  size: width * .05,
                                                ),
                                                SizedBox(
                                                  width: width * .7,
                                                  height: height * .023,
                                                  child: FittedBox(
                                                    alignment: FractionalOffset
                                                        .centerLeft,
                                                    child: Text(
                                                      DateFormat(
                                                              'E, d MMM yyy h:mm a                ')
                                                          .format(date),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 0),
                                            child: Text(
                                                'Pick Up   ${pickUp.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              child: FittedBox(
                                            fit: BoxFit.contain,
                                            child: Text(
                                                'Drop Off   ${dropOff.toString()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                          ))
                                        ],
                                      )
                                    ]),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
