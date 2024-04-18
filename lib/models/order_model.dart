import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/services.dart';
import 'package:sayaaratukcom/models/user_model.dart';

class OrderModel {
  String id;
  ServiceModel service;
  String user;
  Timestamp createdAt;
  String description;
  String vehicle;
  GeoPoint originPoint;
  String originAddress;
  GeoPoint destinationPoint;
  String destinationAddress;
  String paymentOption;
  String status;

  OrderModel(
      {required this.id,
      required this.service,
      required this.user,
      required this.createdAt,
      required this.description,
      required this.vehicle,
      required this.originPoint,
      required this.originAddress,
      required this.destinationPoint,
      required this.destinationAddress,
      required this.paymentOption,
      required this.status});

  Map<String, dynamic> toJson() => {
        'id': id,
        'service': service.toJson(),
        'user': user,
        'createdAt': createdAt,
        'description': description,
        'vehicle': vehicle,
        'originPoint': originPoint,
        'originAddress': originAddress,
        'destinationPoint': destinationPoint,
        'destinationAddress': destinationAddress,
        'paymentOption': paymentOption,
        'status': status,
      };

  static OrderModel fromJson(Map<String, dynamic> json) => OrderModel(
      id: json['id'],
      service: ServiceModel.fromJson(json['service']),
      user: json['user'],
      createdAt: json['createdAt'],
      description: json['description'],
      vehicle: json['vehicle'],
      originPoint: json['originPoint'],
      originAddress: json['originAddress'],
      destinationPoint: json['destinationPoint'],
      destinationAddress: json['destinationAddress'],
      paymentOption: json['paymentOption'],
      status: json['status']);
}

Stream<List<OrderModel>> streamOrders() => FirebaseFirestore.instance
    .collection("orders")
    .where("user", isEqualTo: userProfile.uid)
    .orderBy('createdAt', descending: true)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList());
