import 'package:farmlink/components/my_button.dart';
import 'package:farmlink/screens/equipment_screen.dart';
import 'package:farmlink/screens/my_equipment_screen_empty.dart';
import 'package:flutter/material.dart';
import '../components/my_text_field.dart';

class CompletePaymentPage extends StatefulWidget {
  const CompletePaymentPage({super.key});

  @override
  State<CompletePaymentPage> createState() => _CompletePaymentPageState();
}

class _CompletePaymentPageState extends State<CompletePaymentPage> {
  final refController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm Listing',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(children: [
          Text(
            'Enter Mpesa \nReference Number',
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              controller: refController,
              hintText: 'eg DBGFXFGBXX5',
              obscureText: false),
          const SizedBox(height: 20.0),
          Text(
            'Your Equipment will be added to the Platform once Verified',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          MyButton(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyEquipmentPage(),
                  ),
                );
              },
              text: "Complete"),
        ]),
      ),
    );
  }
}
