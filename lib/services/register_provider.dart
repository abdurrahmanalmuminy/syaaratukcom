import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/provider_model.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

Future registerProvider(context,
    {required String uid,
    required String phone,
    required String identity,
    required String name,
    required String service}) async {
  final providerDoc =
      FirebaseFirestore.instance.collection("waiting_list").doc(uid);

  final provider = ProviderModel(
      uid: uid,
      phone: phone,
      identity: identity,
      name: name,
      service: service,
      avatarUrl: "");

  try {
    final json = provider.toJson();

    await providerDoc.set(json);
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
  Navigator.pop(context);
}
