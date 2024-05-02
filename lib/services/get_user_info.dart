import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/user_model.dart';

Future<UserModel?> getUserInfo({required String uid}) async {
  try {
    DocumentSnapshot userSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      return UserModel(
          phone: userData['phone'],
          uid: userData['uid'],
          name: userData['name'],
          avatarUrl: userData['avatarUrl'],
          email: userData['email'],
          gender: userData['gender'],
          balance: userData['balance'].toDouble());
    }
  } catch (e) {
    log(e.toString());
    return null;
  }
  return null;
}
