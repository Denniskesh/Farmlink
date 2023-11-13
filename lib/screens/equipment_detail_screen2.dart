import 'package:farmlink/screens/confirm_listing.dart';
import 'package:farmlink/screens/equipment_detail_screen.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';

class ConfirmListingPage extends StatefulWidget {
  const ConfirmListingPage({super.key});

  @override
  State<ConfirmListingPage> createState() => _ConfirmListingPageState();
}

class _ConfirmListingPageState extends State<ConfirmListingPage> {
  bool acceptTerms = false;
  bool tickMpesa = false;
  String selectedPackage = 'With Operator'; // Initialize the selected gender
  List<String> packageOptions = ['With Operator', 'Without Operator'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Confirm Listing',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            const SizedBox(height: 20.0),
            const Text(
              'You are required to pay a one time fee of Kes 1000 for your equipent to be listed on our platform. Read and Accept the Terms and Conditions then click on the Make Payment Button below to proceed with Payment. You will be redirected to Sim ToolKit to completed the transaction ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 60,
            ),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: tickMpesa,
              onChanged: (value) {
                setState(() {
                  tickMpesa = value!;
                });
              },
              title: Text(
                'Mpesa',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 10.0),
            CheckboxListTile(
              controlAffinity: ListTileControlAffinity.leading,
              value: acceptTerms,
              onChanged: (value) {
                setState(() {
                  acceptTerms = value!;
                });
              },
              title: const Text('I accept the terms and conditions'),
            ),
            MyButton(
                onTap: () {
                  if (acceptTerms && tickMpesa) {
                    // User accepted terms, you can navigate to the next screen or perform other actions.
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompletePaymentPage(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            'Ensure that Mpesa is checked and Accept Terms & Conditions')));
                  }
                },
                text: "Make Payment"),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomLeft,
              child: ElevatedButton(
                onPressed: () {
                  //if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EquipmentDetailPage(),
                    ),
                  );
                },
                // },
                child: const Text('Previous'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
