import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String message;
  final String receiverId;
  final Timestamp timestamp;
  final String senderEmail;

  Message({
    required this.senderId,
    required this.message,
    required this.receiverId,
    required this.timestamp,
    required this.senderEmail,
  });

  // Factory method to create a Message object from a Map
  // factory Message.fromMap(Map<String, dynamic> map) {
  //  return Message(
  //   senderId: map['senderId'] ?? '',
  ///   message: map['message'] ?? '',
  //   receiverId: map['receiverId'] ?? '',
  //   timestamp: map['timestamp'] != null
  //    .fromMillisecondsSinceEpoch(map['timestamp'])
  //      : DateTime.now(),
  ////   senderEmail: map['senderEmail'] ?? '',
  //  );
  // }

  // Convert the Message object to a Map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'senderEmail': senderEmail,
    };
  }
}
