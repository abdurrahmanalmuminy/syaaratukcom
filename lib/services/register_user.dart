import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/menu/navigation.dart';
import 'package:sayaaratukcom/services/messaging_services.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

Future registerUser(
    {required String uid,
    required String phone,
    required String name,
    required String email,
    required String gender}) async {
  final userDoc = FirebaseFirestore.instance.collection("users").doc(uid);

  final user = UserModel(
      uid: uid,
      phone: phone,
      name: name,
      avatarUrl: "",
      email: email,
      gender: gender,
      balance: 0.0);

  final json = user.toJson();

  await userDoc.set(json);
}

void signUp(context,
    {required String name,
    required String email,
    required String gender}) async {
  try {
    User user = FirebaseAuth.instance.currentUser!;
    registerUser(
        uid: user.uid,
        phone: user.phoneNumber ?? "",
        name: name,
        email: email,
        gender: gender);
    bool registered = await initUser();
    if (registered) {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => const Navigation()));
    }
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
}

Future<bool> initUser() async {
  try {
    User currentUser = FirebaseAuth.instance.currentUser!;

    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.uid)
        .get();
    if (userSnapshot.exists) {
      Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;

      userProfile = UserModel(
          phone: userData['phone'],
          uid: userData['uid'],
          name: userData['name'],
          avatarUrl: userData['avatarUrl'],
          email: userData['email'],
          gender: userData['gender'],
          balance: userData['balance'].toDouble());

      await MessagingServices().initNotifications(uid: userProfile.uid);

      return true;
    }
  } catch (e) {
    log(e.toString());
    print(e);
    return false;
  }
  return false;
}
