import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import '../models/booking_model.dart';

class BookingManager extends ChangeNotifier {
  final CollectionReference bookings =
      FirebaseFirestore.instance.collection('bookings');
  final Uuid _bookingid = const Uuid();

  Future<void> saveBookingDetails(Booking booking,
      {required String userId}) async {
    try {
      // Generate a unique ID for the booking
      String bookingId = _bookingid.v4();

      await bookings.doc(bookingId).set({
        'userId': userId,
        'equipmentId': booking.equipmentId,
        'package': booking.package,
        'pickUp': booking.pickUp,
        'dropOff': booking.dropOff,
        'landSize': booking.landSize,
        'totalAmount': booking.totalAmount,
        'equipmentType': booking.equipmentType,
        'duration': booking.duration,
        'rate': booking.rate,
        'date': booking.date
      });

      // Notify listeners that a change has occurred
      notifyListeners();
    } catch (e) {
      print('Error saving booking details: $e');
    }
  }
}

Future<List> getOrders() async {
  CollectionReference collectionRef1 =
      FirebaseFirestore.instance.collection('bookings');
  QuerySnapshot one = await collectionRef1
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
  final allData1 = one.docs.map((doc) => doc.data()).toList();

  // Get data from docs and convert map to List

  debugPrint(allData1.toString());

  return allData1;
}
