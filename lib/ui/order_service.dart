import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/addition/colors.dart';
import 'package:sayaaratukcom/addition/padding.dart';
import 'package:sayaaratukcom/addition/services.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:sayaaratukcom/ui/select_address.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(UIcons.regularRounded.angle_right)),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: bodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                heading(context,
                    title: serviceItem.label,
                    subTitle: serviceItem.description),
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
                choose(
                    hint: "عنوان الإستلام",
                    indicator: "اختر العنوان",
                    icon: UIcons.regularRounded.map_marker,
                    controller: vehicle,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => const SelectAddress(),
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
                          builder: (context) => const SelectAddress(),
                          fullscreenDialog: true));
                    }),
                gap(height: 10),
                choose(
                    hint: "المركبة",
                    indicator: "اختر مركبتك",
                    icon: UIcons.regularRounded.car_side,
                    controller: vehicle,
                    onPressed: () {}),
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
                primaryButton(context, "التالي"),
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
