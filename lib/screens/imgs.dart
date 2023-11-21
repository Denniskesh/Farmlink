import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/models/equipment_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Images extends StatefulWidget {
  const Images({super.key});

  @override
  ImageC createState() => ImageC();
}

class ImageC extends State<Images> {
  var collectionReference = FirebaseFirestore.instance.collection('requests');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: getImages(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final orders = snapshot.data!; //

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title: Text(
                            orders.docs[index].get('imageUrl'),
                          ),
                          leading: Image.network(
                              orders.docs[index].get('imageUrl'),
                              fit: BoxFit.fill),
                        );
                      });
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

Future<QuerySnapshot> getImages() {
  return FirebaseFirestore.instance.collection("equipment").get();
}
