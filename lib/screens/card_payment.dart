import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/styles/dimentions.dart';
import 'package:sayaaratukcom/utils/payment_result.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class CardPayment extends StatefulWidget {
  final OfferModel offer;
  const CardPayment({super.key, required this.offer});

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  late final PaymentConfig paymentConfig;

  @override
  void initState() {
    super.initState();
    paymentConfig = PaymentConfig(
      publishableApiKey: "pk_test_Tf73EfskuZaM4a9qNiccjfoQvbi7CgVTQ1Xd29ET",
      amount: widget.offer.price.ceil() * 100,
      description: "مزود الخدمة: ${widget.offer.serviceProvider[1]}",
      creditCard: CreditCardConfig(saveCard: false, manual: false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: pageBar(context, title: "إدفع بالبطاقة"),
      body: Padding(
        padding: Dimensions.bodyPadding,
        child: Column(
          children: [
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
