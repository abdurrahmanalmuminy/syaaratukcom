import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/models/services.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/order_page.dart';
import 'package:sayaaratukcom/utils/translate_error.dart';
import 'package:sayaaratukcom/widgets/progress_dialog.dart';
import 'package:sayaaratukcom/widgets/snack_bar.dart';

Future sendOrder(context,
    {required ServiceModel service,
    required String description,
    required String vehicle,
    required GeoPoint originPoint,
    required String originAddress,
    required GeoPoint destinationPoint,
    required String destinationAddress,
    required String paymentOption}) async {
  final orderDoc = FirebaseFirestore.instance.collection("orders").doc();

  Function closeProgressDialog = progressDialog(context);

  final order = OrderModel(
      id: orderDoc.id,
      service: service,
      user: userProfile.uid,
      createdAt: Timestamp.now(),
      description: description,
      vehicle: vehicle,
      originPoint: originPoint,
      originAddress: originAddress,
      destinationPoint: destinationPoint,
      destinationAddress: destinationAddress,
      paymentOption: paymentOption,
      status: "في إنتظار العروض");

  try {
    final json = order.toJson();

    await orderDoc.set(json);
  } catch (e) {
    closeProgressDialog();
    log(e.toString());
    snackBar(context, translateError(e.toString()));
  }
  Navigator.pop(context);
  Navigator.of(context).pushReplacement(
      CupertinoPageRoute(builder: (context) => OrderPage(order: order)));
}
