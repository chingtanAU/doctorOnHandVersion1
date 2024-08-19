import 'package:doctorppp/globals.dart';
import 'package:doctorppp/screens/editProfile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../validatorsAuth/auth.dart';
import 'appbar_widget.dart';
import '../../persistance/userCrud.dart' as crud;

bool isAlpha(String str) {
  return RegExp(r'^[a-zA-Z]+$').hasMatch(str);
}

// This class handles the Page to edit the Name Section of the User Profile.
class EditNameFormPage extends StatefulWidget {
  EditNameFormPage({super.key});
  final authController = Get.find<AuthController>();
  @override
  EditNameFormPageState createState() {
    return EditNameFormPageState();
  }
}

class EditNameFormPageState extends State<EditNameFormPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    secondNameController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String fName, String lName) async {
    await crud.updateUser(auth.currentUser!.uid, {"fName": fName, "lName": lName});
    await widget.authController.fetchUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              width: 330,
              child: Text(
                "What's Your Name?",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: TextFormField(
                      // Handles Form Validation for First Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        } else if (!isAlpha(value)) {
                          return 'Only Letters Please';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'First Name'),
                      controller: firstNameController,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 16, 0),
                  child: SizedBox(
                    height: 100,
                    width: 150,
                    child: TextFormField(
                      // Handles Form Validation for Last Name
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        } else if (!isAlpha(value)) {
                          return 'Only Letters Please';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'Last Name'),
                      controller: secondNameController,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 330,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate() &&
                          isAlpha(firstNameController.text) &&
                          isAlpha(secondNameController.text)) {
                        await updateUserValue(firstNameController.text, secondNameController.text)
                            .then((value) => Get.to(ProfilePage()));
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
