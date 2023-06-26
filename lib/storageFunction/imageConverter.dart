import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../globals.dart' as globals;
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;






Future<String> imageToString(String imagePath) async {

  final Reference storageRef = globals.storage.ref().child(imagePath);
  // Get the image file as a byte array
  final File imageFile = File(imagePath);
  List<int> imageBytes = await imageFile.readAsBytes();
  // Convert the image byte array to a Base64-encoded string
  String base64Image = base64Encode(imageBytes);

  return base64Image;
}

void storeImageInFirestore(String imageString) {


  // Create a new document in a collection
  CollectionReference imagesCollection = globals.firestore.collection('images');
  DocumentReference documentReference = imagesCollection.doc();
  // Store the image string in the document
  documentReference.set({'image': imageString})
      .then((value) {
    print('Image stored in Firestore');
  })
      .catchError((error) {
    print('Failed to store image: $error');
  });
}

Future<String> getImageURL(String path) async {
  final storageRef = globals.storage.ref();
  firebase_storage.Reference ref = storageRef.child(path);
  final url = await ref.getDownloadURL();

  print(url);
  return url ;
}
