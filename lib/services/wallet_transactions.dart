import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/transaction_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/services/register_user.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

Future addToWallet(context, {required double amount}) async {
  final userDoc =
      FirebaseFirestore.instance.collection("users").doc(userProfile.uid);

  try {
    await userDoc.update({"balance": userProfile.balance + amount}).then(
        (value) => initUser());
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
}

Future deductionFromWallet(context, {required double amount}) async {
  final userDoc =
      FirebaseFirestore.instance.collection("users").doc(userProfile.uid);

  try {
    await userDoc.update({"balance": userProfile.balance - amount}).then(
        (value) => initUser());
  } catch (e) {
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
}

Future createTransaction(context,
    {required String transaction, required double amount}) async {
  final transactionDoc = FirebaseFirestore.instance
      .collection("users")
      .doc(userProfile.uid)
      .collection("transactions")
      .doc();

  final transactionModel = TransactionModel(
      transaction: transaction, amount: amount, dueAt: Timestamp.now());

  try {
    final json = transactionModel.toJson();
    await transactionDoc.set(json);
  } catch (e) {
    log(e.toString());
  }
}