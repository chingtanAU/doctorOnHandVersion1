import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;
GoogleSignIn googleSign = GoogleSignIn();

final GlobalKey<FormFieldState> roleKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> conPassKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> fNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> lNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> addressKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> clinicListKey = GlobalKey<FormFieldState>();

final GlobalKey<FormFieldState> clinicNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> clinicPhoneKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> clinicAddressKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> doctorSpeciality = GlobalKey<FormFieldState>();








final List<GlobalKey<FormFieldState>> regUserKeys = [passKey, conPassKey, emailKey, fNameKey, lNameKey, roleKey, phoneKey,addressKey];
final List<GlobalKey<FormFieldState>> regDoctorKeys = [passKey, conPassKey, emailKey, fNameKey,
  lNameKey, roleKey, phoneKey,addressKey,clinicListKey,clinicNameKey,clinicPhoneKey,clinicAddressKey,doctorSpeciality];

final GlobalKey<FormFieldState> passLoginKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailLoginKey = GlobalKey<FormFieldState>();

final List<GlobalKey<FormFieldState>> loginKeys = [passLoginKey, emailLoginKey];


