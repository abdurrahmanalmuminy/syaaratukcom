import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String formattedDateTime =
      DateFormat("MMM dd, yyyy - HH:mm").format(dateTime);
  return formattedDateTime;
}

String timeAgo(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);
  if (difference.inSeconds < 10) {
    return 'قبل قليل';
  } else if (difference.inSeconds < 60) {
    return 'قبل ${difference.inSeconds} ث';
  } else if (difference.inMinutes < 60) {
    return 'قبل ${difference.inMinutes} د';
  } else if (difference.inHours < 24) {
    return 'قبل ${difference.inHours} س';
  } else if (difference.inDays < 7) {
    return 'قبل ${difference.inDays} ي';
  } else {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
