import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String user;
  String message;
  Timestamp sentAt;

  ChatModel(
      {required this.user, required this.message, required this.sentAt});

  Map<String, dynamic> toJson() =>
      {'user': user, 'message': message, 'sentAt': sentAt};

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      ChatModel(
          user: json['user'],
          message: json['message'],
          sentAt: json['sentAt']);
}

Stream<List<ChatModel>> streamChat(orderId) =>
    FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .collection("chat")
        .orderBy('sentAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatModel.fromJson(doc.data()))
            .toList());