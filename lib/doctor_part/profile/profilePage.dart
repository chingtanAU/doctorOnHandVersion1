import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfileScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController specializationController = TextEditingController();
  final TextEditingController clinicNameController = TextEditingController();
  final TextEditingController clinicAddressController = TextEditingController();
  final TextEditingController clinicPhoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController(); // New controller

  final RxString name = "Dr. John Doe".obs;
  final RxString specialization = "Cardiologist".obs;
  final RxString clinicName = "ABC Clinic".obs;
  final RxString clinicAddress = "123 Main Street".obs;
  final RxString clinicPhone = "555-555-5555".obs;
  final RxString description = "".obs; // New RxString

  @override
  Widget build(BuildContext context) {
    nameController.text = name.value;
    specializationController.text = specialization.value;
    clinicNameController.text = clinicName.value;
    clinicAddressController.text = clinicAddress.value;
    clinicPhoneController.text = clinicPhone.value;
    descriptionController.text = description.value; // Set the text field value

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade800,
                  ],
                ),
              ),
              child: Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              name.value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              specialization.value,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Clinic Name:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(() => Text(
                    clinicName.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  SizedBox(height: 16),
                  Text(
                    "Clinic Address:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(() => Text(
                    clinicAddress.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  SizedBox(height: 16),
                  Text(
                    "Clinic Phone:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Obx(() => Text(
                    clinicPhone.value,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  SizedBox(height: 32),
                  Text(
                    "Description:", // New text field label
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: descriptionController, // New text field
                    decoration: InputDecoration(
                      hintText: 'Enter a description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      _showUpdateDialog(context);
                    },
                    child: Text("Update Profile"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    nameController.text = name.value;
    specializationController.text = specialization.value;
    clinicNameController.text = clinicName.value;
    clinicAddressController.text = clinicAddress.value;
    clinicPhoneController.text = clinicPhone.value;
    descriptionController.text = description.value; // Set the text field value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update Profile"),
          content: SingleChildScrollView(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: specializationController,
                decoration: InputDecoration(labelText: "Specialization"),
              ),
              TextField(
                controller: clinicNameController,
                decoration: InputDecoration(labelText: "Clinic Name"),
              ),
              TextField(
                controller: clinicAddressController,
                decoration: InputDecoration(labelText: "Clinic Address"),
              ),
              TextField(
                controller: clinicPhoneController,
                decoration: InputDecoration(labelText: "Clinic Phone"),
              ),
              TextField(
                controller: descriptionController, // New text field
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                name.value = nameController.text;
                specialization.value = specializationController.text;
                clinicName.value = clinicNameController.text;
                clinicAddress.value = clinicAddressController.text;
                clinicPhone.value = clinicPhoneController.text;
                description.value = descriptionController.text; // Update the RxString value
                Navigator.pop(context);
              },
              child: Text("Update"),
            ),
          ],
        );
      },
    );
  }
}