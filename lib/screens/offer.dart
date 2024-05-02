import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

void showOffer(context, OfferModel offerData, OrderModel order) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Scaffold(
            appBar: appBar(context, title: "عرض"),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Column(
                  children: [
                    const Text(
                        "سأقوم بنقل سيارتك بإستخدام السطحة بشكل احترافي وسريع، مقابل مبلغ 112 ريال"),
                    gap(height: 10),
                    offer(context, offerData, clickable: false, order: order),
                    gap(height: 10),
                    orderPathIndicator(context, [order.originAddress, order.destinationAddress]),
                    const Expanded(child: SizedBox()),
                    primaryButton(context, "قبول العرض", onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      });
}
