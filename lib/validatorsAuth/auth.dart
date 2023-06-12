import 'package:doctorppp/entity/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../globals.dart' as globals;
import '../screens/homepage.dart';
import 'Validator.dart';
import '../persistance/userCrud.dart' as userCrud;


Future<bool> onLogin(BuildContext context) async{
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

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Homepage()));
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








Future<void> onRegister(BuildContext context) async{


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
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Homepage()));
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
