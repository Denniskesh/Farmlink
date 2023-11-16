import 'package:farmlink/services/owner_manager.dart';
import 'package:flutter/material.dart';
import '../models/owner_model.dart';
import 'equipment_detail_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class OwnerDetailPage extends StatefulWidget {
  final void Function()? onPressed;
  const OwnerDetailPage(
      {super.key,
      required Null Function(dynamic item) onCreate,
      required Null Function(dynamic item) onUpdate,
      this.onPressed});

  @override
  State<OwnerDetailPage> createState() => _OwnerDetailPageState();
}

class _OwnerDetailPageState extends State<OwnerDetailPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final idnoController = TextEditingController();
  final locationController = TextEditingController();
  final townController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  File? imageFile;

  void _saveOwnerDetails() {
    if (_formKey.currentState!.validate()) {
      OwnerModel user = OwnerModel(
        //ownerID: ownerID,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        dob: dobController.text,
        idNumber: idnoController.text,
        gender: selectedGender,
        location: locationController.text,
        town: townController.text,
        imageUrl: imageFile != null ? imageFile!.path : '',
      );

      OwnerManager userManager = OwnerManager();
      userManager.saveUserData(user, imageFile!.path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EquipmentDetailPage(),
        ),
      );
    }
  }

  Future<void> uploadImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
      }
    });
  }

  String selectedGender = 'Male'; // Initialize the selected gender
  List<String> genderOptions = ['Male', 'Female', 'Other'];

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
        child: ListView(
          children: [
            Text(
              'Owner\'s Details',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Enter your full name',
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.mail),
                      hintText: 'Enter Email',
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid Email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Enter a phone number',
                      labelText: 'Phone',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid phone number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: dobController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      hintText: 'Enter your date of birth',
                      labelText: 'Date of Birth',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid date';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: idnoController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.privacy_tip),
                      hintText: 'Enter ID Number',
                      labelText: 'ID Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter valid ID number';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField(
                    value: selectedGender,
                    items: genderOptions.map((gender) {
                      return DropdownMenuItem(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value!;
                      });
                    },
                    decoration: const InputDecoration(
                        icon: Icon(Icons.attribution_outlined),
                        labelText: 'Gender'),
                  ),
                  TextFormField(
                    controller: locationController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_location),
                      hintText: 'Enter Locationr',
                      labelText: 'County',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: townController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_location),
                      hintText: 'Enter Nearest Town',
                      labelText: 'Nearest Town',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildUploadCard(),
                  Text(
                    imageFile != null
                        ? "Selected File: ${imageFile!}"
                        : 'No file selected',
                  ),
                  const SizedBox(height: 20.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () => _saveOwnerDetails(),
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUploadCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Upload a Photo of your ID or \nOperator\'s License',
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
