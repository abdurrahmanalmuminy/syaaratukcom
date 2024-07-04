import 'package:moyasar/moyasar.dart';

void onPaymentResult(result) {
  if (result is PaymentResponse) {
    switch (result.status) {
      case PaymentStatus.paid:
        print("paid");
        break;
      case PaymentStatus.failed:
        print("failed");
        // handle failure.
        break;
      case PaymentStatus.initiated:
      case PaymentStatus.authorized:
      case PaymentStatus.captured:
    }
  }
}
