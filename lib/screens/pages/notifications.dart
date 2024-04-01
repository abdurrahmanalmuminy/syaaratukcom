import 'package:flutter/material.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "الإشعارات"),
      body: Column(
        children: [
          notification(context,
              subject: "سطحة - #2799",
              message:
                  "تعطلت سيارتي في طريق سفر وأحتاج نقلها إلى ورشة باستخدام سطحة",
              time: "قبل 9 د"),
        ],
      ),
    );
  }
}