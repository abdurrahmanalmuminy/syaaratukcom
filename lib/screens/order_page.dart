import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/models/order_model.dart';
import 'package:sayaaratukcom/services/send_order.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/format_timestamp.dart';
import 'package:sayaaratukcom/widgets/show_dialog.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class OrderPage extends StatefulWidget {
  final OrderModel order;
  const OrderPage({super.key, required this.order});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    OrderModel order = widget.order;

    return Scaffold(
      appBar: pageBar(context, title: order.service.label),
      body: Padding(
        padding: Dimensions.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            order.description != ""
                ? Column(
                    children: [
                      Text(order.description),
                      gap(height: 25),
                    ],
                  )
                : const SizedBox(),
            moreItem(context,
                label: "#${order.id}", icon: UIcons.regularRounded.id_badge),
            moreItem(context,
                label: timeAgo(order.createdAt),
                icon: UIcons.regularRounded.time_oclock),
            moreItem(context,
                label: order.paymentOption, icon: UIcons.regularRounded.wallet),
            moreItem(context,
                label: order.status, icon: UIcons.regularRounded.list_check),
            gap(height: 25),
            orderPathIndicator(
                context,
                [order.originAddress, order.destinationAddress],
                LatLng(order.originPoint.latitude, order.originPoint.longitude),
                LatLng(order.destinationPoint.latitude,
                    order.destinationPoint.longitude)),
            order.status == "جاري التنفيذ"
                ? Row(
                    children: [
                      Expanded(
                        child: moreItem(context,
                            label: "إلغاء الطلب",
                            icon: UIcons.regularRounded.cross,
                            color: AppColors.red, onTap: () {
                          showAlertDialog(context,
                              title: "إلغاء الطلب",
                              content: order.paymentOption != "الدفع الإلكتروني"
                                  ? "هل أنت متأكد من إلغاء الطلب؟"
                                  : "هل أنت متأكد من إلغاء الطلب؟ سيتم إرجاع المبلغ المدفوع إلى المحفظة", onOk: () {
                            cancelOrder(context, order.id, order.offerId);
                          });
                        }),
                      ),
                      Expanded(
                        child: moreItem(context,
                            label: "إنهاء الطلب",
                            icon: UIcons.regularRounded.social_network,
                            color: Colors.green.shade500,
                            onTap: () {}),
                      ),
                    ],
                  )
                : const SizedBox(),
            gap(height: 25),
            order.status != "ملغي"
                ? section(context,
                    title: order.status == "جاري التنفيذ"
                        ? "مزود الخدمة"
                        : "العروض",
                    noPadding: true)
                : const SizedBox(),
            gap(height: 10),

            //offers
            order.status != "ملغي"
                ? StreamBuilder<List<OfferModel>>(
                    stream: order.status == "جاري التنفيذ"
                        ? streamAcceptedOffer(order.id)
                        : streamAllOffers(order.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        log(snapshot.error.toString());
                        return errorOccurred();
                      } else if (snapshot.hasData) {
                        final offerItems = snapshot.data!;
                        if (offerItems.isNotEmpty) {
                          final offerItemsList = offerItems;
                          return Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              children: offerItemsList
                                  .map((offerData) => offer(context, offerData,
                                      order: order,
                                      clickable: order.status != "جاري التنفيذ",
                                      chat: order.status == "جاري التنفيذ"))
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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
