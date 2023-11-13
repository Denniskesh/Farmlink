import 'dart:io';

import 'package:farmlink/screens/equipment_detail_screen2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class EquipmentDetailPage extends StatefulWidget {
  const EquipmentDetailPage({super.key});

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  File? selectedFile;
  String selectedFuelType = 'Diesel'; // Initialize the selected gender
  List<String> fuelOptions = ['Diesel', 'Petrol', 'Electricity', 'Gas'];

  String selectedMechanizationType =
      'Crop Planting'; // Initialize the selected gender
  List<String> mechanizationTypeOptions = [
    'Harvesting',
    'Harrowing',
    'Crop Planting',
    'Land Preparation',
    'Ploughing',
    'Seeding',
    'Spraying',
    'Water Pumping',
    'Transporting',
    'Tilling',
    'Threshing'
  ];

  String selectedEquipmentType = 'Tractor'; // Initialize the selected gender
  List<String> equipmentTypeOptions = [
    'Harvestor',
    'Cultivator',
    'Airseeder',
    'Baler',
    'Bulldozer',
    'Cane Loader',
    'Sprayer',
    'Combined Harvestor',
    'Plough',
    'Harrower',
    'Tractor',
    'Water Pump'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Equipment to Listing',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          Text(
            'Equipment Details',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Mechanization Type:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedMechanizationType,
                    items: mechanizationTypeOptions.map((mechanizationType) {
                      return DropdownMenuItem(
                        value: mechanizationType,
                        child: Text(mechanizationType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedMechanizationType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Equipment Type:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedEquipmentType,
                    items: equipmentTypeOptions.map((equipmentType) {
                      return DropdownMenuItem(
                        value: equipmentType,
                        child: Text(equipmentType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedEquipmentType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Name/Plate No:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter text',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Model:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter Equipment Model',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Rate/Cost:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Kes per Ha/Hour',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Fuel Type:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedFuelType,
                    items: fuelOptions.map((fuelType) {
                      return DropdownMenuItem(
                        value: fuelType,
                        child: Text(fuelType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedFuelType = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Label
                Text(
                  'Consumption Rate:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Liters per Ha/Hour',
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildUploadCard(),
          Text(
            selectedFile != null
                ? "Selected File: ${selectedFile!}"
                : 'No file selected',
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                //if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ConfirmListingPage(),
                  ),
                );
              },
              // },
              child: const Text('Continue'),
            ),
          ),
        ]),
      ),
    );
  }

  Widget buildUploadCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Upload a clear Photo of the \nEquipment showing the Plate No.',
          // style: Theme.of(context).textTheme.displaySmall,
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                final file = File(result.files.single.name);
                selectedFile = file;
                setState(() {});
              } else {
                // User canceled the picker
                // You can show snackbar or fluttertoast
                // here like this to show warning to user

                ScaffoldMessenger.of(context as BuildContext)
                    .showSnackBar(const SnackBar(
                  content: Text('Please select file'),
                ));
              }
            },
            child: const Text('Upload File'),
          ),
        ),
      ],
    );
  }
}
