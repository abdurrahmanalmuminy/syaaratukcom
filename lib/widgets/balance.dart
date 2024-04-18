import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/user_model.dart';
import 'package:sayaaratukcom/screens/wallet.dart';
import 'package:uicons/uicons.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        showWallet(context);
      },
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2)),
      child: Row(
        children: [
          Icon(
            UIcons.solidRounded.wallet,
            color: Colors.black,
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("الرصيد", style: TextStyle(color: Colors.black)),
              Text(
                "${userProfile.balance} ر.س",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black),
              )
            ],
          )
        ],
      ),
    );
  }
}
