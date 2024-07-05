import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/screens/payment/result.dart';
import 'package:sayaaratukcom/services/send_order.dart';
import 'package:sayaaratukcom/services/wallet_transactions.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class PaymentPage extends StatefulWidget {
  final OfferModel offer;
  const PaymentPage({super.key, required this.offer});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final PaymentConfig paymentConfig;

  @override
  void initState() {
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: "pk_test_Tf73EfskuZaM4a9qNiccjfoQvbi7CgVTQ1Xd29ET",
      amount: widget.offer.price.ceil() * 100,
      description: "مزود الخدمة: ${widget.offer.serviceProvider[1]}",
      creditCard: CreditCardConfig(saveCard: false, manual: false),
      applePay: ApplePayConfig(
          merchantId: "marchant.sayaaratukcom.sa",
          label: "سيارتك كوم",
          manual: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    void onPaymentResult(result) {
      if (result is PaymentResponse) {
        switch (result.status) {
          case PaymentStatus.paid:
            acceptOffer(context, widget.offer.orderId, widget.offer.offerId);
            createTransaction(context, transaction: "طلب #${widget.offer.orderId}", amount: widget.offer.price)
                .then((value) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Result()),
              );
            });

            break;
          case PaymentStatus.failed:
            print("failed");
            // handle failure.
            break;
          case PaymentStatus.initiated:
          case PaymentStatus.authorized:
          case PaymentStatus.captured:
            break;
        }
      } else if (result is PaymentCanceledError) {
        print("Payment was canceled");
        // handle cancellation
      } else {
        print("Unknown payment result");
        // handle unknown result
      }
    }

    return Scaffold(
      appBar: pageBar(context, title: "إدفع بالبطاقة"),
      body: Padding(
        padding: Dimensions.bodyPadding,
        child: Column(
          children: [
            Platform.isIOS
                ? Column(
                    children: [
                      ApplePay(
                          config: paymentConfig,
                          onPaymentResult: onPaymentResult),
                      orDivider(),
                    ],
                  )
                : const SizedBox(),
            CreditCard(
              config: paymentConfig,
              onPaymentResult: onPaymentResult,
              locale: const Localization.ar(cvc: "رمز التحقق cvc"),
            )
          ],
        ),
      ),
    );
  }
}
