import 'package:flutter/material.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageBar(context, title: "سطحة - #2799"),
      body: Padding(
        padding: Dimensions.bodyPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("تعطلت سيارتي في طريق سفر وأحتاج نقلها إلى ورشة باستخدام سطحة"),
            gap(height: 25),
            moreItem(context, label: "قبل 10د", icon: UIcons.regularRounded.time_oclock),
            moreItem(context, label: "الدفع الإلكتروني", icon: UIcons.regularRounded.wallet),
            moreItem(context, label: "في إنتظار العروض", icon: UIcons.regularRounded.list_check),
            gap(height: 25),
            orderPathIndicator(context),
            gap(height: 25),
            section(context, title: "العروض", noPadding: true),
            gap(height: 10),
            offer(context)
          ],
        ),
      ),
    );
  }
}
