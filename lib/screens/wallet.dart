import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/transaction_model.dart';
import 'package:sayaaratukcom/models/user_model.dart';
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
                                  text: "${userProfile.balance}",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
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
                      StreamBuilder<List<TransactionModel>>(
                stream: streamTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    return errorOccurred();
                  } else if (snapshot.hasData) {
                    final transactionItems = snapshot.data!;
                    if (transactionItems.isNotEmpty) {
                      final transactionItemsList = transactionItems;
                      return Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: transactionItemsList
                              .map((transactionData) =>
                                  transaction(context, transactionData))
                              .toList(),
                        ),
                      );
                    } else {
                      return noData(customNoData: "لا توجد عمليات");
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}
