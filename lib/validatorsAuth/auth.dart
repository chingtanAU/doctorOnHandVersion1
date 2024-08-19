import 'dart:convert';

import 'package:doctorppp/entity/DoctorProfile.dart';
import 'package:doctorppp/entity/HealthCarePhacility.dart';
import 'package:doctorppp/entity/userProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Controllers/patientMeetingsController.dart';
import '../globals.dart' as globals;
import '../globals.dart';
import 'Validator.dart';
import '../persistance/userCrud.dart' as userCrud;
import '../persistance/FacilityService.dart' as clinicCrud;
import '../../widgets/notifcationScreen.dart';

class AuthController extends GetxController {
  Rx<UserProfile> userData = Rx<UserProfile>(UserProfile.empty());
  late Rx<User?> firebaseUser;
  final isLoading = true.obs;
  final authStateChanged = false.obs;
  final isUserDataLoaded = false.obs;

  String? get currentUserId => auth.currentUser?.uid;
  String? get currentUserFullName =>
      "${userData.value.fName} ${userData.value.lName}";

  @override
  Future<void> onInit() async {
    super.onInit();
    Get.lazyPut(() => PatientMeetingsController(), fenix: true);
    Get.put(NotificationController());

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  Future<void> _setInitialScreen(User? user) async {
    if (user == null) {
      authStateChanged.value = true;
      isLoading.value = false;
      isUserDataLoaded.value = false;
    } else {
      await fetchUserInfo();
    }
  }

  Future<void> fetchUserInfo() async {
    if (auth.currentUser != null) {
      isLoading.value = true;
      isUserDataLoaded.value = false;
      await userCrud.fetchUserInfo(auth.currentUser!.uid).then((value) {
        if (value != null) {
          userData.value = value;
          Get.find<AuthController>();
          Get.put(PatientMeetingsController());
        } else {
          print("value is null");
          print(auth.currentUser!.uid);
          print(auth.currentUser!.email);
          print(auth.currentUser!.phoneNumber);
        }
        authStateChanged.value = true;
        isLoading.value = false;
        isUserDataLoaded.value = true;
      });
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> onLogin() async {
    bool canLogin = false;
    bool done = true;
    for (int i = 0; i < globals.loginKeys.length; i++) {
      if (!globals.loginKeys[i].currentState!.validate()) {
        done = false;
      }
    }
    if (done) {
      try {
        print("reached");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: globals.emailLoginKey.currentState!.value,
            password: globals.passLoginKey.currentState!.value);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          FireError.userNotFoundError = true;
          globals.emailLoginKey.currentState!.validate();
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          FireError.wrongPassError = true;
          globals.passLoginKey.currentState!.validate();
        }
      }
    }
    return canLogin;
  }

  Future<void> onRegister() async {
    bool done = true;
    if (globals.roleKey.currentState!.value == "Patient") {
      for (int i = 0; i < globals.regUserKeys.length; i++) {
        print(i);
        if (globals.regUserKeys[i].currentState != null) {
          print(globals.regUserKeys[i].currentState!.value);
          if (!globals.regUserKeys[i].currentState!.validate()) {
            done = false;
          }
        } else {
          print('Current state is null for index $i');
        }
      }
    } else if (globals.roleKey.currentState!.value == "Doctor") {
      int y;
      if (globals.clinicListKey.currentState?.value?.id == "0000") {
        y = globals.regDoctorKeys.length;
      } else {
        y = 10;
      }
      for (int i = 0; i < y; i++) {
        print(i);
        if (globals.regDoctorKeys[i].currentState != null) {
          print(globals.regDoctorKeys[i].currentState!.value);
          if (!globals.regDoctorKeys[i].currentState!.validate()) {
            done = false;
          }
        } else {
          print('Current state is null for index $i');
        }
      }
    }

    print(done);

    if (done) {
      String email = globals.emailKey.currentState!.value;
      String password = globals.passKey.currentState!.value;
      String? uid;
      print(email);
      try {
        print("reached");
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => uid = value.user?.uid);

        String role = globals.roleKey.currentState!.value;
        String first = globals.fNameKey.currentState!.value;
        String last = globals.lNameKey.currentState!.value;
        String phone;
        if (globals.phoneKey.currentState != null) {
          phone = globals.phoneKey.currentState!.value;
        } else {
          print('Current state is null for phone key');
          phone = "0000000000";
        }

        String address = globals.addressKey.currentState!.value;

        UserProfile u;
        HealthCarePhacility? clinic;
        String clinicId;
        if (globals.roleKey.currentState?.value == "Patient") {
          u = UserProfile(
            role: role,
            fName: first,
            lName: last,
            email: email,
            address: address,
            phone: phone,
          );
        } else {
          String clinicName;

          if (globals.clinicListKey.currentState!.value!.id == "0000") {
            clinicName = globals.clinicNameKey.currentState!.value;
            String clinicAddress = globals.clinicAddressKey.currentState!.value;
            String clinicPhone = globals.clinicPhoneKey.currentState!.value;
            String combinedStrings = clinicName + clinicAddress + clinicPhone;
            var bytes = utf8.encode(combinedStrings);
            var hash = sha256.convert(bytes);
            clinicId = hash.toString();

            clinic = HealthCarePhacility(
                id: clinicId,
                name: clinicName,
                address: clinicAddress,
                number: clinicPhone);
          } else {
            clinicId = globals.clinicListKey.currentState!.value!.id;
            clinicName = globals.clinicListKey.currentState!.value!.name;
          }

          u = DoctorProfile(
              role: role,
              fName: first,
              lName: last,
              email: email,
              address: address,
              phone: phone,
              speciality: globals.doctorSpeciality.currentState!.value,
              clinicId: clinicId);
        }

        if (clinic != null) {
          print("aaaaaaaaaaaaaa ${clinic.id}");
          await clinicCrud.addClinicOnlyWithOppointment(
              clinic.id, clinic.toJson());
        }

        userCrud.addUser(uid!, u.toJson());

        print("DOne");

        String toast = "Please check your email and verify it!";
        Fluttertoast.showToast(
            msg: toast,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.white,
            textColor: Colors.red,
            fontSize: 16.0);
        Get.offNamed("/home");

      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          FireError.setEmailUseError(true);
          globals.emailKey.currentState!.validate();
        }
      }
    }
  }

  Future<void> logOut() async {
    await globals.auth.signOut();
    isUserDataLoaded.value = false;
    userData.value = UserProfile.empty();
  }

  Future<String> resetPassword({required String email}) async {
    String result = '';
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => result = 'email send successfully')
        .catchError((e) => result = e.code);

    return result;
  }
}
