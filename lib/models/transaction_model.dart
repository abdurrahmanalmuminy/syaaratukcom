import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayaaratukcom/models/user_model.dart';

class TransactionModel {
  String transaction;
  double amount;
  Timestamp dueAt;

  TransactionModel(
      {required this.transaction, required this.amount, required this.dueAt});

  Map<String, dynamic> toJson() =>
      {'transaction': transaction, 'amount': amount, 'dueAt': dueAt};

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          transaction: json['transaction'],
          amount: json['amount'],
          dueAt: json['dueAt']);
}

Stream<List<TransactionModel>> streamTransactions() =>
    FirebaseFirestore.instance
        .collection("users")
        .doc(userProfile.uid)
        .collection("transactions")
        .orderBy('dueAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromJson(doc.data()))
            .toList());
