import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          order(context,
              subject: "سطحة - #2799",
              content:
                  "تعطلت سيارتي في طريق سفر وأحتاج نقلها إلى ورشة باستخدام سطحة",
              time: "قبل 9 د",
              status: "في إنتظار العروض"),
        ],
      ),
    );
  }
}
