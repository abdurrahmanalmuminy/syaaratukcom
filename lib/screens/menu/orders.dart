import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "الطلبات"),
      body: userProfile.uid != "" ? Column(
        children: [
          StreamBuilder<List<OrderModel>>(
                stream: streamOrders(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    return errorOccurred();
                  } else if (snapshot.hasData) {
                    final cartItems = snapshot.data!;
                    if (cartItems.isNotEmpty) {
                      final cartItemsList = cartItems;
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: cartItemsList
                              .map((orderData) =>
                                  order(context, orderData))
                              .toList(),
                        ),
                      );
                    } else {
                      return noData();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
        ],
      ) : SizedBox(width: double.infinity, child: askToLogin(context)),
    );
  }
}
