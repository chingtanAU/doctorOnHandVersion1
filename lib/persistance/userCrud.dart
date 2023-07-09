import 'package:cloud_firestore/cloud_firestore.dart';
import '../entity/userProfile.dart';
import '../globals.dart';

final CollectionReference userCollection = firestore.collection("Users");




Future<void> addUser(String uid,Map<String, dynamic> user) async {
  userCollection.doc(uid).set(user);
}

Future<UserProfile?> fetchUserInfo(String id) async{
  UserProfile? user ;
  await userCollection.doc(id).get().then((doc) {
    print(doc.data());
    final data = doc.data() as Map<String, dynamic>;
    user= UserProfile.fromJson(data);
    print(user?.address);
  }
  );
  return user;
}

Future<void> updateUser(String uid, Map<String, dynamic> value ) async {
  await userCollection.doc(uid).update(value);
}




