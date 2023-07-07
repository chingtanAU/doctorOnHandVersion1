import 'package:doctorppp/entity/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../globals.dart' as globals;
import '../globals.dart';
import 'Validator.dart';
import '../persistance/userCrud.dart' as userCrud;


class AuthController extends GetxController {

  late Rx<User?> firebaseUser;


  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

  }

  _setInitialScreen(User? user) {
    if (user == null) {

      // if the user is not found then the user is navigated to the Register Screen
      Get.offNamed('/login');

    } else {

      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offNamed('/home');

    }
  }


  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );


    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


  Future<bool> onLogin() async{
    bool canLogin = false;
    bool done = true;
    for (int i = 0; i < globals.loginKeys.length; i++){
      if (!globals.loginKeys[i].currentState!.validate()){
        done = false;
      }
    }
    if (done){
      try {
        print("reached");
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: globals.emailLoginKey.currentState!.value,
            password: globals.passLoginKey.currentState!.value
        );

        Get.offNamed("/home");
      }
      on FirebaseAuthException catch (e) {

        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          FireError.userNotFoundError=true;
          globals.emailLoginKey.currentState!.validate();

        }


        else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          FireError.wrongPassError=true;
          globals.passLoginKey.currentState!.validate();
        }

      }

    }
    return canLogin;
  }

  Future<void> onRegister() async{


    bool done = true;
    for (int i = 0; i < globals.regKeys.length; i++){
      if (!globals.regKeys[i].currentState!.validate()){
        done = false;
      }
    }
    print(done);
    if (done) {
      String email = globals.emailKey.currentState!.value;
      String phone = globals.phoneKey.currentState!.value;
      String uid;
      print(email);
      try {
        print("reached");
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: email,
            password: globals.passKey.currentState!.value
        );
        String role = globals.roleKey.currentState!.value;
        String first = globals.fNameKey.currentState!.value;
        String last = globals.lNameKey.currentState!.value;
        String phone = globals.phoneKey.currentState!.value ;
        String address = globals.addressKey.currentState!.value ;

        uid= globals.auth.currentUser!.uid;
        UserProfile u= UserProfile(role:role,fName:first,lName: last,email: email,address: address,phone:phone);
        userCrud.addUser(uid,u.toJson());

        print("DOne");


        String toast = "Please check your email and verify it!";
        Fluttertoast.showToast(msg: toast,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 16.0);
        Get.offNamed("/home");
      }
      on  FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          FireError.setEmailUseError(true);
          globals.emailKey.currentState!.validate();

        }
      }
    }

  }



  Future<void> logOut() async {
    await globals.auth.signOut();
  }

  Future<String> resetPassword({required String email}) async {
    String result='';
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => result='email send successfully')
        .catchError(
            (e) => result= e.code);

    return result ;


  }




}



