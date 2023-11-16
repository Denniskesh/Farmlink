import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmlink/screens/equipment_detail_screen2.dart';
import 'package:farmlink/services/equipment_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/equipment_model.dart';

class EquipmentDetailPage extends StatefulWidget {
  const EquipmentDetailPage({super.key});

  @override
  State<EquipmentDetailPage> createState() => _EquipmentDetailPageState();
}

class _EquipmentDetailPageState extends State<EquipmentDetailPage> {
  final nameController = TextEditingController();
  final modelController = TextEditingController();
  final costController = TextEditingController();
  final consumpionRateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final EquipmentManager _equipmentProvider =
      EquipmentManager(); // Create an instance of the provider
  File? imageFile;

  Future<void> _saveEquipmentDetails() async {
    if (_formKey.currentState!.validate()) {
      // Create EquipmentDetails object with form data
      EquipmentDetails equipmentDetails = EquipmentDetails(
        mechanizationType: selectedMechanizationType,
        equipmentType: selectedEquipmentType,
        name: nameController.text.trim(), // Replace with actual value
        model: modelController.text.trim(), // Replace with actual value
        rate: costController.text.trim(), // Replace with actual value
        fuelType: selectedFuelType,
        consumptionRate:
            consumpionRateController.text.trim(), // Replace with actual value
        imageFile: imageFile,
        packageType: selectedPackage,
      );

      // Set equipment details in the provider
      _equipmentProvider.setEquipmentDetails(equipmentDetails);

      // Save to Firestore
      _equipmentProvider.saveToFirestore();

      // Navigate to ConfirmListingPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ConfirmListingPage(),
        ),
      );
    }
  }

  Future<void> uploadImage() async {
    final FirebaseStorage storage = FirebaseStorage.instance;
    final Reference storageRef = storage.ref().child('images');
    // Pick an image
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Get the file from the picked image
      File imageFile = File(pickedFile.path);

      // Upload the image to Firebase Storage
      TaskSnapshot storageUploadTask =
          await storageRef.child('image.jpg').putFile(imageFile);

      // Get the download URL of the uploaded image
      String downloadURL = await storageUploadTask.ref.getDownloadURL();

      // Save the download URL to Firestore
      await FirebaseFirestore.instance
          .collection('images')
          .add({'url': downloadURL});

      print('Image uploaded successfully!');
    } else {
      print('No image selected.');
    }
  }

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
  String selectedPackage = 'With Operator'; // Initialize the selected gender
  List<String> packageOptions = ['With Operator', 'Without Operator'];

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
          Form(
            key: _formKey,
            child: Padding(
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
                Expanded(
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter text',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter Name/Plate No.';
                      }
                      return null;
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
                  'Model:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                Expanded(
                  child: TextFormField(
                    controller: modelController,
                    decoration: const InputDecoration(
                      hintText: 'eg. HVFGG5400',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field is required';
                      }
                      return null;
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
                  'Rate/Cost:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 6,
                ),
                // Text Input Field
                Expanded(
                  child: TextFormField(
                    controller: costController,
                    decoration: const InputDecoration(
                      hintText: 'Kes per Ha/Hour',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter cost of hire';
                      }
                      return null;
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
                Expanded(
                  child: TextFormField(
                    controller: consumpionRateController,
                    decoration: const InputDecoration(
                      hintText: 'Liters per Ha/Hour',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This Field is required';
                      }
                      return null;
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
                  'Package:',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  width: 10,
                ),
                // Text Input Field
                Expanded(
                  child: DropdownButtonFormField(
                    value: selectedPackage,
                    items: packageOptions.map((packageType) {
                      return DropdownMenuItem(
                        value: packageType,
                        child: Text(packageType),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPackage = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          buildUploadCard(),
          Text(
            imageFile != null
                ? "Selected File: ${imageFile!}"
                : 'No file selected',
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => _saveEquipmentDetails(),
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
            onPressed: () => uploadImage(),
            child: const Text('Upload File'),
          ),
        ),
      ],
    );
  }
}
