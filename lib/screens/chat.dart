import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/chat_model.dart';
import 'package:sayaaratukcom/models/offer_model.dart';
import 'package:sayaaratukcom/services/send_message.dart';
import 'package:sayaaratukcom/styles/colors.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';
import 'package:uicons/uicons.dart';

class Chat extends StatefulWidget {
  final OfferModel offer;
  const Chat({super.key, required this.offer});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          pageBar(context, title: widget.offer.serviceProvider[1], actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(UIcons.regularRounded.flag, color: Colors.red),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(UIcons.regularRounded.info),
        ),
        gap(width: 10),
      ]),
      body: SafeArea(
        child: Column(
          children: [
            note(
                "لا تقدم أي معلومات خاصة أو حساسة، جميع الرسائل مسجلة وفريقنا الفني على إطلاع بها"),
            gap(height: 25),
            StreamBuilder<List<ChatModel>>(
              stream: streamChat(widget.offer.orderId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return errorOccurred();
                } else if (snapshot.hasData) {
                  final chatItems = snapshot.data!;
                  if (chatItems.isNotEmpty) {
                    final chatItemsList = chatItems;
                    return Expanded(
                      child: ListView(
                        reverse: true,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(
                            right: 15, left: 15, bottom: 10),
                        children: chatItemsList
                            .map((chatData) => chatItem(chatData))
                            .toList(),
                      ),
                    );
                  } else {
                    return noData(customNoData: "كن أول من يرسل");
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1, color: AppColors.highlight3))),
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: textField(context,
                          hint: "إكتب..",
                          icon: UIcons.regularRounded.comment,
                          controller: message),
                    ),
                    gap(width: 10),
                    IconButton(
                      onPressed: () {
                        sendMessage(context,
                                message: message.text,
                                orderId: widget.offer.orderId)
                            .then((value) {
                          message.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      icon: Icon(UIcons.regularRounded.paper_plane,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
