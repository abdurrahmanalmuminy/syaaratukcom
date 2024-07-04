// import 'dart:io';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:moyasar/moyasar.dart';
// import 'package:sayaaratukcom/models/offer_model.dart';
// import 'package:sayaaratukcom/screens/payment/payment.dart';
// import 'package:sayaaratukcom/styles/dimentions.dart';
// import 'package:sayaaratukcom/utils/payment_result.dart';
// import 'package:sayaaratukcom/widgets/widgets.dart';
// import 'package:uicons/uicons.dart';

// void paymentOptions(context, {required OfferModel offer}) {
//   final applePaymentConfig = PaymentConfig(
//     publishableApiKey: "pk_test_Tf73EfskuZaM4a9qNiccjfoQvbi7CgVTQ1Xd29ET",
//     amount: offer.price.ceil() * 100,
//     description: 'order #1324',
//     applePay: ApplePayConfig(
//         merchantId: "marchant.sayaaratukcom.sa",
//         label: "سيارتك كوم",
//         manual: true),
//   );

//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
//       ),
//       backgroundColor: Colors.white,
//       builder: (BuildContext context) {
//         return FractionallySizedBox(
//           heightFactor: 0.4,
//           child: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Scaffold(
//               appBar: appBar(context, title: "أساليب الدفع"),
//               body: SafeArea(
//                 child: Padding(
//                   padding: Dimensions.bodyPadding,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text("للمتابعة، اختر أسلوب الدفع"),
//                       gap(height: 25),
//                       Platform.isIOS
//                           ? ApplePay(
//                               config: applePaymentConfig,
//                               onPaymentResult: onPaymentResult,
//                             )
//                           : const SizedBox(),
//                       moreItem(context,
//                           label: "إدفع بالبطاقة",
//                           icon: UIcons.regularRounded.credit_card, onTap: () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(CupertinoPageRoute(
//                             builder: (context) => CardPayment(offer: offer)));
//                       }),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       });
// }
