import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/services/send_order.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/models/services.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:sayaaratukcom/screens/select_address.dart';
import 'package:uicons/uicons.dart';

class OrderService extends StatefulWidget {
  final ServiceModel service;
  const OrderService({super.key, required this.service});

  @override
  State<OrderService> createState() => _OrderServiceState();
}

class _OrderServiceState extends State<OrderService> {
  TextEditingController description = TextEditingController();
  TextEditingController vehicle = TextEditingController();
  List origin = [const GeoPoint(0, 0), ""];
  List destination = [const GeoPoint(0, 0), ""];
  String paymentOption = "الدفع الإلكتروني";

  bool active = false;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    void updateButton() {
      setState(() {
        active = vehicle.text.isNotEmpty &&
                origin[0].latitude != 0 &&
                destination[0].latitude != 0
            ? true
            : false;
      });
    }

    final ServiceModel serviceItem = widget.service;
    return Scaffold(
      appBar: pageBar(context, title: serviceItem.label),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: Dimensions.bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Image.asset(serviceItem.asset, height: 100),
                ),
                gap(height: 15),

                //form
                textField(context,
                    controller: description,
                    hint: "اكتب تفاصيل طلبك",
                    icon: UIcons.regularRounded.align_left,
                    multiline: true),
                gap(height: 10),
                textField(context,
                    controller: vehicle,
                    hint: "المركبة",
                    icon: UIcons.regularRounded.car_side, onChanged: (value) {
                  updateButton();
                }),
                gap(height: 10),
                choose(
                    hint:
                        origin[1] != "" ? origin[1] ?? "--" : "عنوان الإستلام",
                    indicator: "اختر العنوان",
                    icon: UIcons.regularRounded.map_marker,
                    onPressed: () async {
                      try {
                        final List selectedPoint = await Navigator.of(context)
                            .push(CupertinoPageRoute(
                                builder: (context) => const SelectAddress(
                                    address: "عنوان الإستلام"),
                                fullscreenDialog: true));
                        if (!context.mounted) return;
                        if (selectedPoint[0] != null) {
                          setState(() {
                            origin[0] = GeoPoint(selectedPoint[0].latitude,
                                selectedPoint[0].longitude);
                            origin[1] = selectedPoint[1];
                            updateButton();
                          });
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    }),
                gap(height: 10),
                choose(
                    hint: destination[1] != ""
                        ? destination[1] ?? "--"
                        : "عنوان التوصيل",
                    indicator: "اختر العنوان",
                    icon: UIcons.regularRounded.flag,
                    onPressed: () async {
                      try {
                        final List selectedPoint = await Navigator.of(context)
                          .push(CupertinoPageRoute(
                              builder: (context) =>
                                  const SelectAddress(address: "عنوان التوصيل"),
                              fullscreenDialog: true));
                      if (!context.mounted) return;
                      if (selectedPoint[0] != null) {
                        setState(() {
                          destination[0] = GeoPoint(selectedPoint[0].latitude,
                              selectedPoint[0].longitude);
                          destination[1] = selectedPoint[1];
                          updateButton();
                        });
                      }
                      } catch (e) {
                        log(e.toString());
                      }
                    }),
                gap(height: 10),
                dropDown(
                    value: paymentOption,
                    icon: UIcons.regularRounded.wallet,
                    items: ["الدفع الإلكتروني", "الدفع نقداً"],
                    onChanged: (String? newValue) {
                      setState(() {
                        paymentOption = newValue!;
                      });
                    }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            border: Border(
          top: BorderSide(width: 1, color: AppColors.highlight2),
        )),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: Dimensions.bodyPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                primaryButton(context, "التالي",
                    loading: _loading,
                    onPressed: !active || _loading == true
                        ? null
                        : () {
                            setState(() {
                              _loading = true;
                            });
                            sendOrder(context,
                                service: serviceItem,
                                description: description.text,
                                vehicle: vehicle.text,
                                originPoint: origin[0],
                                originAddress: origin[1],
                                destinationPoint: destination[0],
                                destinationAddress: destination[1],
                                paymentOption: paymentOption);
                          }),
                optionB(context,
                    text:
                        "بمجرد إرسال طلبك، ستصلك عروض من مزود الخدمات ولن يتم مشاركة معلوماتك الشخصية",
                    option: "")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
