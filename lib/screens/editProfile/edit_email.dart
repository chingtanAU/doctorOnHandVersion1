import 'package:doctorppp/screens/editProfile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../validatorsAuth/Validator.dart' as validator;
import '../../globals.dart';
import '../../validatorsAuth/auth.dart';
import 'appbar_widget.dart';
import '../../persistance/userCrud.dart' as crud;

// This class handles the Page to edit the Email Section of the User Profile.
class EditEmailFormPage extends StatefulWidget {
  EditEmailFormPage({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();

  @override
  EditEmailFormPageState createState() {
    return EditEmailFormPageState();
  }
}

class EditEmailFormPageState extends State<EditEmailFormPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
 // var user = UserData.myUser;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> updateUserValue(String email) async {
    await crud.updateUser(auth.currentUser!.uid, {"email":email});
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
                    width: 320,
                    child: Text(
                      "What's your email?",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    )),
                Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (email)=>validator.emailValidatro(email!),
                          decoration: const InputDecoration(
                              labelText: 'Your email address'),
                          controller: emailController,
                        ))),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                await updateUserValue(emailController.text);
                                Get.to( ProfilePage());
                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
