import 'package:cloud_firestore/cloud_firestore.dart';

class OfferModel {
  final String orderId;
  final String offerId;
  final double price;
  final String description;
  final List<dynamic> serviceProvider;
  final String status;
  final Timestamp createdAt;

  OfferModel(
      {required this.orderId,
      required this.offerId,
      required this.price,
      required this.description,
      required this.serviceProvider,
      required this.status,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'offerId': offerId,
        'price': price,
        'description': description,
        'serviceProvider': serviceProvider,
        'status': status,
        'createdAt': createdAt
      };

  static OfferModel fromJson(Map<String, dynamic> json) => OfferModel(
      orderId: json['orderId'],
      offerId: json['offerId'],
      price: json["price"],
      description: json["description"],
      serviceProvider: json["serviceProvider"],
      status: json["status"],
      createdAt: json['createdAt']);
}

Stream<List<OfferModel>> streamAllOffers(orderId) => FirebaseFirestore.instance
    .collection("offers")
    .orderBy('createdAt', descending: true)
    .where("orderId", isEqualTo: orderId)
    .where("status", isEqualTo: "في الإنتظار")
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => OfferModel.fromJson(doc.data())).toList());

Stream<List<OfferModel>> streamAcceptedOffer(orderId) => FirebaseFirestore.instance
    .collection("offers")
    .orderBy('createdAt', descending: true)
    .where("orderId", isEqualTo: orderId)
    .where("status", isEqualTo: "تم القبول")
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => OfferModel.fromJson(doc.data())).toList());