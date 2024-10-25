import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayaaratukcom/screens/support.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class IpadLocation extends StatelessWidget {
  const IpadLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("عرض الموقع حالياً غير متاح على أجهزة الأيباد",
              style: Theme.of(context).textTheme.titleMedium),
          gap(height: 10),
          SizedBox(
            width: 200,
            child: primaryButton(context, "تحتاج مساعدة؟", onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => const Support(),
              ));
            }),
          )
        ],
      ),
    );
  }
}
