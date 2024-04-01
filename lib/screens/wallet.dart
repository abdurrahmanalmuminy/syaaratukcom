import 'package:flutter/material.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

void showWallet(context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Scaffold(
              appBar: appBar(context, title: "المحفظة"),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(right: 15, left: 15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 160,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "62.00",
                                  style: Theme.of(context).textTheme.displayMedium,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: " ر.س",
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: AppColors.highlight1),
                                    )
                                  ]),
                            ),
                            Text(
                              "رصيدك الحالي",
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ),
                      section(context, title: "العمليات", noPadding: true),
                      transaction(context, subject: "رسوم الطلب", message: "11 يوليو 2023 - 10:47"),
                      transaction(context, subject: "رسوم الطلب", message: "11 يوليو 2023 - 10:47"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
