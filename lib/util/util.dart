import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatDate(Timestamp date) {
  return DateFormat.yMMMMd().format(date.toDate()).toString();
}

String formatDateTimestamp(Timestamp? timestamp) {
  return DateFormat.yMMMd().add_EEEE().format(timestamp!.toDate());
}

String formatDateFromTimestampHour(Timestamp? timestamp) {
  return DateFormat.jm().format(timestamp!.toDate());
}
