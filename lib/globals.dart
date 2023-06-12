import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';



final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
final FirebaseStorage storage = FirebaseStorage.instance;

final GlobalKey<FormFieldState> roleKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> passKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> conPassKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> fNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> lNameKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> phoneKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> addressKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> clinicsKey = GlobalKey<FormFieldState>();


final List<GlobalKey<FormFieldState>> regKeys = [passKey, conPassKey, emailKey, fNameKey, lNameKey, roleKey, phoneKey,addressKey];

final GlobalKey<FormFieldState> passLoginKey = GlobalKey<FormFieldState>();
final GlobalKey<FormFieldState> emailLoginKey = GlobalKey<FormFieldState>();

final List<GlobalKey<FormFieldState>> loginKeys = [passLoginKey, emailLoginKey];


