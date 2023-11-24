import 'dart:collection';

import 'package:farmlink/screens/confirm_listing.dart';
import 'package:flutter/material.dart';
import '../components/my_text_field.dart';
import 'package:mpesa_flutter_plugin/mpesa_flutter_plugin.dart';

import '../components/my_button.dart';
import 'add_equipment_detail_screen.dart';

class ConfirmListingPage extends StatefulWidget {
  const ConfirmListingPage({super.key});

  @override
  State<ConfirmListingPage> createState() => _ConfirmListingPageState();
}

class _ConfirmListingPageState extends State<ConfirmListingPage> {
  TextEditingController phoneController = TextEditingController();
  bool acceptTerms = false;
  bool tickMpesa = false;
  late double amount;
  late String phone;

  @override
  void initState() {
    super.initState();

    // Initialize M-Pesa keys
    initializeMpesaKeys();
  }

  void initializeMpesaKeys() {
    // Initialize your M-Pesa keys here
    MpesaFlutterPlugin.setConsumerKey('Gd3zC6rU211hPhkbeSst1DVfVVA7qlfw');
    MpesaFlutterPlugin.setConsumerSecret('BLNOXb2RevXAQTED');
  }

  Future<dynamic> mpesaTransaction(
      {required double amount, required String phone}) async {
    dynamic transactionInitialisation;
//Wrap it with a try-catch
    try {
//Run it
      transactionInitialisation =
          await MpesaFlutterPlugin.initializeMpesaSTKPush(
              businessShortCode:
                  '174379', //use your store number if the transaction type is CustomerBuyGoodsOnline
              transactionType: TransactionType
                  .CustomerPayBillOnline, //or CustomerBuyGoodsOnline for till numbers
              amount: amount,
              partyA: phone,
              partyB: '174379',
              callBackURL: Uri(
                  scheme: "https", host: "1234.1234.co.ke", path: "/1234.php"),
              accountReference: 'Farmlink',
              phoneNumber: phone,
              baseUri: Uri(scheme: 'https', host: "sandbox.safaricom.co.ke"),
              transactionDesc: 'Payment for equipment listing',
              passKey:
                  'bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919');
      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());
//you can implement your exception handling here.
//Network un-reachability is a sure exception.

      /*
  Other 'throws':
  1. Amount being less than 1.0
  2. Consumer Secret/Key not set
  3. Phone number is less than 9 characters
  4. Phone number not in international format(should start with 254 for KE)
   */

      print(e.toString());
    }
  }

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
            //Text(
            // 'Enter Mpesa Number',
            // style: Theme.of(context).textTheme.displayMedium,
            // textAlign: TextAlign.center,
            // ),
            // const SizedBox(
            //  height: 20,
            // ),
            //MyTextField(
            //  controller: phoneController,
            // hintText: 'eg 254712345678',
            // obscureText: false),
            const SizedBox(height: 20.0),
            MyButton(
                onTap: () async {
                  var providedContact = await _showTextInputDialog(context);

                  if (providedContact != null) {
                    if (providedContact.isNotEmpty) {
                      mpesaTransaction(phone: providedContact, amount: 1.0);
                    } else {
                      // ignore: use_build_context_synchronously
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Empty Number!'),
                              content: const Text(
                                  "You did not provide a number to be charged."),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: const Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            );
                          });
                    }
                  }

                  if (acceptTerms && tickMpesa) {
                    // User accepted terms, you can navigate to the next screen or perform other actions.
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompletePaymentPage(),
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
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
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EquipmentDetailPage(),
                    ),
                  );
                },
                child: const Text('Previous'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final _textFieldController = TextEditingController();

Future<String?> _showTextInputDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('M-Pesa Number'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "+254712345678..."),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Proceed'),
              onPressed: () =>
                  Navigator.pop(context, _textFieldController.text),
            ),
          ],
        );
      });
}
