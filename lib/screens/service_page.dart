import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/models/services.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:sayaaratukcom/screens/order_page.dart';
import 'package:sayaaratukcom/screens/select_address.dart';
import 'package:uicons/uicons.dart';

class OrderService extends StatefulWidget {
  final ServiceItem service;
  const OrderService({super.key, required this.service});

  @override
  State<OrderService> createState() => _OrderServiceState();
}

class _OrderServiceState extends State<OrderService> {
  String payment = "الدفع الإلكتروني";
  TextEditingController vehicle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ServiceItem serviceItem = widget.service;
    return Scaffold(
      appBar: pageBar(context, title: serviceItem.label),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(serviceItem.description),
                gap(height: 25),
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
                    hint: "اكتب تفاصيل طلبك",
                    icon: UIcons.regularRounded.align_left,
                    multiline: true),
                gap(height: 10),
                textField(context,
                    hint: "المركبة", icon: UIcons.regularRounded.car_side),
                gap(height: 10),
                choose(
                    hint: "عنوان الإستلام",
                    indicator: "اختر العنوان",
                    icon: UIcons.regularRounded.map_marker,
                    controller: vehicle,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const SelectAddress(address: "عنوان الإستلام"),
                          fullscreenDialog: true));
                    }),
                gap(height: 10),
                choose(
                    hint: "عنوان التوصيل",
                    indicator: "اختر العنوان",
                    icon: UIcons.regularRounded.flag,
                    controller: vehicle,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const SelectAddress(address: "عنوان التوصيل"),
                          fullscreenDialog: true));
                    }),
                gap(height: 10),
                dropDown(
                    value: payment,
                    icon: UIcons.regularRounded.wallet,
                    items: ["الدفع الإلكتروني", "الدفع نقداً"],
                    onChanged: (String? newValue) {
                      setState(() {
                        payment = newValue!;
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
            padding: bodyPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                primaryButton(context, "التالي", onPressed: (){
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(
                              builder: (context) => const OrderPage()));
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
