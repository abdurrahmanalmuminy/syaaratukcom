import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/user_model.dart';

class NotificationModel {
  String title;
  String content;
  Timestamp sentAt;

  NotificationModel(
      {required this.title, required this.content, required this.sentAt});

  Map<String, dynamic> toJson() =>
      {'title': title, 'content': content, 'sentAt': sentAt};

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          title: json['title'],
          content: json['content'],
          sentAt: json['sentAt']);
}

Stream<List<NotificationModel>> streamNotification() =>
    FirebaseFirestore.instance
        .collection("users")
        .doc(userProfile.uid)
        .collection("notifications")
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => NotificationModel.fromJson(doc.data()))
            .toList());
