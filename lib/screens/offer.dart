import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/screens/payment/payment.dart';
import 'package:sayaaratukcom/services/send_order.dart';
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
                        offerData.description != ""
                            ? Text(offerData.description)
                            : const SizedBox(),
                        gap(height: 10),
                        offer(context, offerData, clickable: false, order: order),
                        gap(height: 10),
                        orderPathIndicator(
                            context,
                            [order.originAddress, order.destinationAddress],
                            LatLng(order.originPoint.latitude,
                                order.originPoint.longitude),
                            LatLng(order.destinationPoint.latitude,
                                order.destinationPoint.longitude)),
                        const Expanded(child: SizedBox()),
                        primaryButton(context, "قبول العرض", onPressed: () {
                          if (order.paymentOption == "الدفع الإلكتروني") {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (context) =>
                                    PaymentPage(offer: offerData)));
                            // paymentOptions(context, offer: offerData);
                          } else {
                            acceptOffer(context, order.id, offerData.offerId);
                          }
                        })
                      ],
                    ),
                  ),
                ),
              ),
            );
      });
}
