import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InAppChatPage extends StatefulWidget {
  const InAppChatPage({super.key});

  @override
  State<InAppChatPage> createState() => _InAppChatPageState();
}

class _InAppChatPageState extends State<InAppChatPage> {
  @override
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  late User user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _getUser() async {
    User? user = _auth.currentUser;
    if (user != null) {
      setState(() {
        user = user;
      });
    }
  }

  void _sendMessage() async {
    String messageText = _messageController.text.trim();

    if (messageText.isNotEmpty) {
      await _firestore.collection('messages').add({
        'text': messageText,
        'sender': user.email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        // actions: [
        //  IconButton(
        //  icon: Icon(Icons.logout),
        // onPressed: () async {
        //   await _auth.signOut();
        //  Navigator.pop(context);
        // },
        // ),
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<DocumentSnapshot> messages =
                    snapshot.data!.docs.reversed.toList();

                List<Widget> messageWidgets = [];
                for (var message in messages) {
                  String text = message['text'];
                  String sender = message['sender'];

                  Widget messageWidget = ListTile(
                    title: Text(text),
                    subtitle: Text(sender),
                  );

                  messageWidgets.add(messageWidget);
                }

                return ListView(
                  reverse: true,
                  children: messageWidgets,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
