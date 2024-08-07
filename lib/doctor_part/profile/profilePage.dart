import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../validatorsAuth/auth.dart';

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
  final RxString description = "".obs;

  DoctorProfileScreen({super.key}); // New RxString


  @override
  Widget build(BuildContext context) {
    nameController.text = name.value;
    specializationController.text = specialization.value;
    clinicNameController.text = clinicName.value;
    clinicAddressController.text = clinicAddress.value;
    clinicPhoneController.text = clinicPhone.value;
    descriptionController.text = description.value; // Set the text field value
    final authController = Get.find<AuthController>();



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
              child: const Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              " ${authController.userData.value.fName ?? ""} ${authController.userData.value.lName ?? ""}",
              //   "\nHow are you today?",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "${authController.userData.value.speciality1}",

              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Clinic Name:",
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // SizedBox(height: 8),
                  // Obx(() => Text(
                  //   clinicName.value,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //   ),
                  // )),
                  const SizedBox(height: 16),
                  const Text(
                    "Clinic Address:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                    authController.userData.value.address ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  const SizedBox(height: 16),
                  const Text(
                    "Clinic Phone:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Text(
                    authController.userData.value.phone ?? "",
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  )),
                  const SizedBox(height: 32),
                  const Text(
                    "Description:", // New text field label
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: descriptionController, // New text field
                    decoration: const InputDecoration(
                      hintText: 'Enter a description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      _showUpdateDialog(context);
                    },
                    child: const Text("Update Profile"),
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
          title: const Text("Update Profile"),
          content: SingleChildScrollView(

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: specializationController,
                decoration: const InputDecoration(labelText: "Specialization"),
              ),
              TextField(
                controller: clinicNameController,
                decoration: const InputDecoration(labelText: "Clinic Name"),
              ),
              TextField(
                controller: clinicAddressController,
                decoration: const InputDecoration(labelText: "Clinic Address"),
              ),
              TextField(
                controller: clinicPhoneController,
                decoration: const InputDecoration(labelText: "Clinic Phone"),
              ),
              TextField(
                controller: descriptionController, // New text field
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
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
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }
}