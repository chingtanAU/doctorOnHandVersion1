import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../globals.dart' as globals;
import '../../../validatorsAuth/Validator.dart' as validator;
import '../../../validatorsAuth/Validator.dart';

import 'package:flutter/material.dart';
import '../../../validatorsAuth/auth.dart';



class MyLogin extends StatelessWidget {

   MyLogin({Key? key}) : super(key: key);

  final TextEditingController _emailResetPass = TextEditingController();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left:  MediaQuery.of(context).size.width * 0.03, top: MediaQuery.of(context).size.width * 0.03),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery
                        .of(context)
                        .size
                        .height * 0.3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (text) {
                              FireError.userNotFoundError=false;
                            },
                            key: globals.emailLoginKey,
                            validator: (email)=>validator.emailValidatro(email!),
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Email",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            onChanged: (text) {
                              FireError.wrongPassError=false;
                            },
                            key: globals.passLoginKey,
                            validator: (pass)=>validator.passwordValidator(pass!),

                            style: const TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Remember Me",
                                style: const TextStyle(color: Colors.black),),
                             // Checkbox(
                            //  ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () {
                                      Get.offAllNamed("/home");
                                       // auth.onLogin(context);


                                      authController.onLogin();
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                            onPressed: () { authController.signInWithGoogle();},
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage("assets/google_logo.png"),
                                    height: 35.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Sign in with Google',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),



                          const SizedBox(
                            height: 25,
                          ),


                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Get.offNamed("/register");;
                                },
                                child: Text(
                                  'Sign Up',
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {Get.defaultDialog(
                                      title: 'Enter your email',
                                      content: TextFormField(
                                        validator: (email)=> validator.emailValidatro(email!) ,
                                        controller: _emailResetPass ,
                                        decoration:InputDecoration(

                                        ) ,
                                      ),
                                      confirm:
                                      MaterialButton(
                                        child: Text('Submit'),
                                        onPressed: () async {
                                          Get.snackbar ( await authController.resetPassword(email: _emailResetPass.text),'');
                                          _emailResetPass.clear();

                                        },
                                      )







                                  );},
                                  child: Text(
                                    'Forgot Password',
                                    style: const TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Color(0xff4c505b),
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }




}
