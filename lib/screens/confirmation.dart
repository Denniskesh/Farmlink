import 'package:flutter/material.dart';

class ConfirmationPage extends StatefulWidget {
  @override
  Confirmation createState() => Confirmation();
}

class Confirmation extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Successful'),
        ),
        body: Container(
          child: SizedBox(child: FittedBox()),
        ),
      ),
    );
  }
}
