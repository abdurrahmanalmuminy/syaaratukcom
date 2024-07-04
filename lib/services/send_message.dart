import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/chat_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

Future sendMessage(context, {required String message, required String orderId}) async {
  final messageDoc = FirebaseFirestore.instance
      .collection("orders")
      .doc(orderId)
      .collection("chat")
      .doc();

  final messageModel = ChatModel(
      user: userProfile.uid, message: message, sentAt: Timestamp.now());

  try {
    final json = messageModel.toJson();
    await messageDoc.set(json);
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
}
