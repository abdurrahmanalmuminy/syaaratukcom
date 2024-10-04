import 'package:cloud_firestore/cloud_firestore.dart';

class SupportModel {
  String title;
  String message;
  String uid;
  Timestamp sentAt;

  SupportModel(
      {required this.title, required this.message, required this.uid, required this.sentAt});

  Map<String, dynamic> toJson() =>
      {'title': title, 'message': message, 'uid': uid, 'sentAt': sentAt};

  factory SupportModel.fromJson(Map<String, dynamic> json) =>
      SupportModel(
          title: json['title'],
          message: json['message'],
          uid: json['uid'],
          sentAt: json['sentAt']);
}