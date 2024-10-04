import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/support_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

void requestSupport(context,
    {required String title,
    required String message}) async {
  final requestDoc = FirebaseFirestore.instance.collection("support requests").doc();
  final request = SupportModel(
      title: title, message: message, uid: userProfile.uid, sentAt: Timestamp.now());

  try {
    final json = request.toJson();

    await requestDoc.set(json);
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
  Navigator.pop(context);
}
