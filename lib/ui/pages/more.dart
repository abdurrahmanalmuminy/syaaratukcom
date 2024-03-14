import 'package:flutter/material.dart';
import 'package:sayaaratukcom/addition/widgets.dart';
import 'package:uicons/uicons.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  State<More> createState() => _MoreState();
}

class _MoreState extends State<More> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "المزيد"),
      body: Column(
        children: [
          profile(context),
          gap(height: 25),
          moreItem(context,
              label: "إعمل معنا", icon: UIcons.regularRounded.briefcase),
          moreItem(context,
              label: "الشروط والأحكام", icon: UIcons.regularRounded.info),
          moreItem(context,
              label: "من نحن؟", icon: UIcons.regularRounded.interrogation),
          moreItem(context,
              label: "سياسة الخصوصية", icon: UIcons.regularRounded.lock),
          moreItem(context,
              label: "الدعم الفني", icon: UIcons.regularRounded.headset),
          moreItem(context,
              label: "الإعدادات", icon: UIcons.regularRounded.settings_sliders),
        ],
      ),
    );
  }
}
