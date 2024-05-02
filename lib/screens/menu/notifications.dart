import 'package:flutter/material.dart';
import 'package:sayaaratukcom/models/notification_model.dart';
import 'package:sayaaratukcom/widgets/widgets.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, title: "الإشعارات"),
      body: Column(
        children: [
          StreamBuilder<List<NotificationModel>>(
            stream: streamNotification(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return errorOccurred();
              } else if (snapshot.hasData) {
                final notifications = snapshot.data!;
                if (notifications.isNotEmpty) {
                  final notificationsList = notifications;
                  return Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: notificationsList
                          .map((notificationsData) => notification(context, notificationsData))
                          .toList(),
                    ),
                  );
                } else {
                  return noData();
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )
        ],
      ),
    );
  }
}